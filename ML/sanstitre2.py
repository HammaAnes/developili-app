import pandas as pd
import re
from sqlalchemy import create_engine
from sklearn.preprocessing import MultiLabelBinarizer
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

# Combine encoded languages with the original data
df = pd.concat([df, df_languages], axis=1)

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

# Find top developers
def find_top_developers(languages, experience_level):
    """
    Find the top developers for the given languages.
    """
    results = {"single_language": {}, "combined": [], "individual": {}}

    if len(languages) == 1:  # If only one language is specified
        lang = languages[0]
        top_devs = df[
            (df[lang] == 1) & (df['experience_level'] == experience_level)
        ].head(5)
        results["single_language"][lang] = list(top_devs["developer_id"])
        return results

    # Developers who know at least 2 out of the requested languages
    df["match_score"] = df["languages"].apply(
        lambda x: len(set(languages).intersection(x))
    )
    all_languages_match = df[
        (df["match_score"] >= 2) & (df["experience_level"] == experience_level)
    ].head(5)
    results["combined"] = list(all_languages_match["developer_id"])

    # Individual languages
    excluded_ids = set(all_languages_match["developer_id"])
    for lang in languages:
        matching_devs = df[
            (df[lang] == 1)
            & (df['experience_level'] == experience_level)
            & (~df["developer_id"].isin(excluded_ids))
        ].head(5)
        results["individual"][lang] = list(matching_devs["developer_id"])

    return results

# Main Script
try:
    client_input = input("Enter the type of developer you're looking for (e.g., 'Python, Java, React'): ").upper()
    client_budget = input("Enter your budget (Small, Medium, High): ").upper()

    languages_input, experience_input = extract_features_from_text(client_input, client_budget)

    developer_results = find_top_developers(languages_input, experience_input)

    print("\nResults:")
    print(developer_results)

except ValueError as e:
    print(f"Error: {e}")
