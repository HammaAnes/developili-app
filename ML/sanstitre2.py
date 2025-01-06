import pandas as pd
import re
from sqlalchemy import create_engine
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import MultiLabelBinarizer
from sklearn.metrics import accuracy_score, classification_report
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

# Evaluate the model
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)

print(f"\nModel Accuracy: {accuracy:.2f}")
print("\nClassification Report:")
print(classification_report(y_test, y_pred))

# Extract languages and budget from user input
def extract_features_from_text(text, budget):
    """
    Extract programming languages from input text and map budget to experience levels.
    """
    text = text.upper()
    languages_pattern = r"(" + "|".join(re.escape(lang) for lang in mlb.classes_) + r")"

    languages = re.findall(languages_pattern, text)

    if not languages:
        raise ValueError("No programming languages found in the input text. Please specify at least one valid programming language.")

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

# Find the top 5 developers based on user input
def find_top_5_developers(text, budget):
    """
    Find the top 5 developers based on client input, filtering by required languages and budget.
    """
    languages_input, experience_input = extract_features_from_text(text, budget)

    # Filter matching developers
    matching_developers = df[
        df['languages'].apply(lambda x: bool(set(languages_input).intersection(x))) &
        (df['experience_level'] == experience_input)
    ]

    if matching_developers.empty:
        print("\nNo developers matched your criteria.")
        return []

    # Avoid SettingWithCopyWarning
    matching_developers = matching_developers.copy()
    matching_developers['match_score'] = matching_developers['developer_name'].apply(
        lambda dev: model.predict_proba(X.loc[df[df['developer_name'] == dev].index])[0].max() * 100
    )

    # Return the top 5 developers based on match scores
    return matching_developers.sort_values(by='match_score', ascending=False).head(15)

# Main Script
try:
    client_input = input("Enter the type of developer you're looking for (e.g., 'Python, Java, React'): ").upper()
    client_budget = input("Enter your budget (Small, Medium, High): ").upper()

    top_matches = find_top_5_developers(client_input, client_budget)

    if not isinstance(top_matches, list) and not top_matches.empty:
        print("\nTop 5 matches:")
        for _, row in top_matches.iterrows():
            print(f"User ID: {row['developer_id']}, {row['developer_name']}: {row['match_score']:.2f}% "
                  f"(Experience: {row['experience_level']}, Languages: {', '.join(row['languages'])})")
    else:
        print("\nNo developers matched your criteria.")
except ValueError as e:
    print(f"Error: {e}")
