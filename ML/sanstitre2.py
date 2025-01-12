import pandas as pd
import re
from sqlalchemy import create_engine
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import MultiLabelBinarizer
from imblearn.over_sampling import RandomOverSampler
import sys

# Database connection details
db_config = {
    'user': 'avnadmin',
    'password': 'AVNS_GAdGpf1DtUda-fCprv-',
    'host': 'developili-db-developili.k.aivencloud.com',
    'port': '20939',
    'database': 'defaultdb'
}

def load_developer_data():
    """
    Load developer data, fetching skills and experience levels from the database.
    """
    try:
        engine = create_engine(
            f"postgresql://{db_config['user']}:{db_config['password']}@{db_config['host']}:{db_config['port']}/{db_config['database']}"
        )
        query = """
        SELECT 
            u.id AS developer_id, 
            u.username AS developer_name, 
            dp.skills AS languages,
            dp.rating AS experience_level
        FROM "User" u
        INNER JOIN DeveloperProfile dp ON u.id = dp.user_id
        WHERE u.role = 'developer' AND u.is_active = TRUE;
        """
        df = pd.read_sql(query, engine)
        if df.empty:
            print("No data retrieved from the database.")
            return None
        return df
    except Exception as e:
        print("Failed to load developer data:", e)
        return None

# Load data
df = load_developer_data()
if df is None or df.empty:
    sys.exit("No valid developer data found. Exiting.")

# Preprocess languages
def preprocess_languages(value):
    """
    Preprocess the 'languages' column to handle missing or invalid values.
    """
    if isinstance(value, list):
        return [lang.strip().upper() for lang in value if isinstance(lang, str) and lang.strip()]
    if pd.isnull(value):
        return []
    if isinstance(value, str):
        return [lang.strip().upper() for lang in value.split(',') if lang.strip()]
    return []

df['languages'] = df['languages'].apply(preprocess_languages)

# Map ratings to experience levels
def map_experience_level(rating):
    """
    Map numeric ratings to experience levels.
    """
    if rating <= 3.5:
        return "Junior"
    elif 3.5 < rating <= 4.5:
        return "Mid-Level"
    return "Senior"

df['experience_level'] = df['experience_level'].apply(map_experience_level)

# Encode languages using MultiLabelBinarizer
mlb = MultiLabelBinarizer()
languages_encoded = mlb.fit_transform(df['languages'])
df_languages = pd.DataFrame(languages_encoded, columns=mlb.classes_)

# Prepare input (X) and output (y)
X = df_languages
y = df['experience_level']

# Balance the dataset
ros = RandomOverSampler(random_state=42)
X_resampled, y_resampled = ros.fit_resample(X, y)

# Split dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X_resampled, y_resampled, test_size=0.2, random_state=42)

# Train a RandomForestClassifier with hyperparameter tuning
param_grid = {
    'n_estimators': [100, 200, 500],
    'max_depth': [10, 15, 20],
    'min_samples_split': [2, 5],
    'min_samples_leaf': [1, 2],
}
grid_search = GridSearchCV(
    estimator=RandomForestClassifier(random_state=42),
    param_grid=param_grid,
    scoring='accuracy',
    cv=3,
    n_jobs=-1
)
grid_search.fit(X_train, y_train)

# Best model
model = grid_search.best_estimator_

# Extract languages and budget from user input
def extract_features_from_text(text, budget):
    """
    Extract programming languages from input text and map budget to experience levels.
    """
    text = text.upper()
    languages_pattern = r"(" + "|".join(re.escape(lang) for lang in mlb.classes_) + r")"

    languages = re.findall(languages_pattern, text)

    # Map budget to experience levels
    if "SMALL" in budget.upper():
        experience_level = "Junior"
    elif "MEDIUM" in budget.upper():
        experience_level = "Mid-Level"
    elif "HIGH" in budget.upper():
        experience_level = "Senior"
    else:
        raise ValueError("Invalid budget specified. Use 'Small', 'Medium', or 'High'.")

    return list(set(languages)), experience_level

# Find developers for all input languages or return top developers for experience level
def find_top_developers(languages, experience_level):
    """
    Find the top developers based on the matching criteria.
    If no languages are specified, return top developers based on experience level and rating.
    """
    results = {
        "all_languages": [],
        "individual_languages": {}
    }

    if languages:  # If languages are provided
        all_languages_devs = df[
            df['languages'].apply(lambda x: set(languages).issubset(x)) &
            (df['experience_level'] == experience_level)
        ]
        if not all_languages_devs.empty:
            all_languages_devs = all_languages_devs.copy()
            all_languages_devs['match_score'] = all_languages_devs['developer_name'].apply(
                lambda dev: model.predict_proba(X.loc[df[df['developer_name'] == dev].index])[0].max() * 100
            )
            results["all_languages"] = all_languages_devs.sort_values(by='match_score', ascending=False).head(5)['developer_id'].tolist()

        excluded_ids = set(results["all_languages"])
        for lang in languages:
            individual_devs = df[
                df['languages'].apply(lambda x: lang in x) &
                (df['experience_level'] == experience_level) &
                (~df['developer_id'].isin(excluded_ids))
            ]
            if not individual_devs.empty:
                individual_devs = individual_devs.copy()
                individual_devs['match_score'] = individual_devs['developer_name'].apply(
                    lambda dev: model.predict_proba(X.loc[df[df['developer_name'] == dev].index])[0].max() * 100
                )
                results["individual_languages"][lang] = individual_devs.sort_values(by='match_score', ascending=False).head(5)['developer_id'].tolist()
    else:  # If no languages are provided
        fallback_devs = df[df['experience_level'] == experience_level]
        if not fallback_devs.empty:
            fallback_devs = fallback_devs.copy()
            fallback_devs['match_score'] = fallback_devs['developer_name'].apply(
                lambda dev: model.predict_proba(X.loc[df[df['developer_name'] == dev].index])[0].max() * 100
            )
            # Sort by rating (highest first) and experience level, return top 5
            results["all_languages"] = fallback_devs.sort_values(by=['experience_level', 'experience_level'], ascending=[True, False]).head(5)['developer_id'].tolist()

    return results

# Main Script
try:
    client_input = input("Enter the type of developer you're looking for (e.g., 'Python, Java, React'): ").upper()
    client_budget = input("Enter your budget (Small, Medium, High): ").upper()

    try:
        languages_input, experience_input = extract_features_from_text(client_input, client_budget)
    except ValueError as e:
        print("No specific languages provided or found. Finding the best developers for your experience level.")
        languages_input, experience_input = [], map_experience_level(client_budget)

    results = find_top_developers(languages_input, experience_input)
    print("\nResults:", results)

except ValueError as e:
    print(f"Error: {e}")
