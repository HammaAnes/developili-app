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

def extract_max_salary(salary_range):
    """
    Extract the maximum salary from a salary range string (e.g., '4000-6000€' -> 6000, '<1000€' -> 1000, '>5000€' -> 5000).
    """
    if pd.isnull(salary_range):
        return None
    
    # If the salary range is like "4000-6000€"
    match = re.search(r'(\d+)-(\d+)', salary_range)
    if match:
        return int(match.group(2))  # Extract the max salary

    # If the salary range is like "<1000€"
    match_less_than = re.search(r'<\s*(\d+)', salary_range)
    if match_less_than:
        return int(match_less_than.group(1))  # Extract the salary after "<"

    # If the salary range is like ">5000€"
    match_greater_than = re.search(r'>\s*(\d+)', salary_range)
    if match_greater_than:
        return int(match_greater_than.group(1))  # Extract the salary after ">"

    # If no valid salary range is found, return None
    return None

def load_developer_data():
    """
    Load developer data, fetching skills, experience levels, and salary range from question response mapping.
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
            dp.rating AS experience_level,
            qrm.response AS salary_range
        FROM "User" u
        INNER JOIN DeveloperProfile dp ON u.id = dp.user_id
        LEFT JOIN QuestionResponseMapping qrm ON dp.user_id = qrm.user_id AND qrm.question_id = 23
        WHERE u.role = 'developer' AND u.is_active = TRUE;
        """
        df = pd.read_sql(query, engine)
        if df.empty:
            print("No data retrieved from the database.")
            return None
        
        # Apply the max salary extraction
        df['max_salary'] = df['salary_range'].apply(extract_max_salary)
        
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
    Extract programming languages from input text and map budget to a maximum salary threshold.
    """
    text = text.upper()
    languages_pattern = r"(" + "|".join(re.escape(lang) for lang in mlb.classes_) + r")"

    languages = re.findall(languages_pattern, text)

    # Map budget to maximum salary
    if "SMALL" in budget.upper():
        max_salary = 1000
    elif "MEDIUM" in budget.upper():
        max_salary = 6000
    elif "HIGH" in budget.upper():
        max_salary = 80000
    else:
        raise ValueError("Invalid budget specified. Use 'Small', 'Medium', or 'High'.")

    return list(set(languages)), max_salary

# Find developers for all input languages or return top developers for salary range
def find_top_developers(languages, max_salary):
    """
    Find the top developers based on the matching criteria.
    """
    results = {
        "all_languages": [],
        "individual_languages": {}
    }

    if not languages:  # If no languages are provided
        # Return the best developers within the salary range
        fallback_devs = df[df['max_salary'] <= max_salary]
        if not fallback_devs.empty:
            results["all_languages"] = fallback_devs.sort_values(by='experience_level', ascending=False).head(5)['developer_id'].tolist()

    elif len(languages) == 1:  # If just one language is provided
        all_languages_devs = df[ 
            df['languages'].apply(lambda x: set(languages).issubset(x)) & 
            (df['max_salary'] <= max_salary)
        ]
        if not all_languages_devs.empty:
            results["all_languages"] = all_languages_devs.sort_values(by='experience_level', ascending=False).head(5)['developer_id'].tolist()

    else:  # If multiple languages are provided
        all_languages_devs = df[ 
            df['languages'].apply(lambda x: set(languages).issubset(x)) & 
            (df['max_salary'] <= max_salary)
        ]
        if not all_languages_devs.empty:
            results["all_languages"] = all_languages_devs.sort_values(by='experience_level', ascending=False).head(5)['developer_id'].tolist()

        excluded_ids = set(results["all_languages"])
        for lang in languages:
            individual_devs = df[ 
                df['languages'].apply(lambda x: lang in x) & 
                (df['max_salary'] <= max_salary) & 
                (~df['developer_id'].isin(excluded_ids))
            ]
            if not individual_devs.empty:
                results["individual_languages"][lang] = individual_devs.sort_values(by='experience_level', ascending=False).head(5)['developer_id'].tolist()

    return results

# Main Script
try:
    client_input = input("Enter the type of developer you're looking for (e.g., 'Python, Java, React'): ").upper()
    client_budget = input("Enter your budget (Small, Medium, High): ").upper()

    try:
        languages_input, max_salary_input = extract_features_from_text(client_input, client_budget)
    except ValueError as e:
        print("No specific languages provided or found. Finding the best developers for your salary range.")
        languages_input, max_salary_input = [], None

    results = find_top_developers(languages_input, max_salary_input)
    print("\nResults:", results)

except ValueError as e:
    print(f"Error: {e}")
