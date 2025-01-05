import pandas as pd
import re
from sqlalchemy import create_engine
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import MultiLabelBinarizer

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
    Load developer data including experience level and skills from the database.
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
            qrm.response AS experience_level,
            dp.rating
        FROM "User" u
        INNER JOIN DeveloperProfile dp ON u.id = dp.user_id
        LEFT JOIN QuestionResponseMapping qrm ON qrm.user_id = u.id
        LEFT JOIN Questionnaire q ON q.id = qrm.question_id AND q.question = 'What is your experience level?'
        WHERE u.role = 'developer' AND u.is_active = TRUE AND qrm.response IS NOT NULL;
        """
        df = pd.read_sql(query, engine)
        if df.empty:
            print("No data retrieved from the database.")
            return None
        return df
    except Exception as e:
        print("Failed to load developer data:", e)
        return None

def normalize_experience_level(exp):
    """
    Normalize experience level values from the database to match predefined keys.
    """
    exp = exp.upper()
    if "JUNIOR" in exp:
        return "JUNIOR"
    elif "MID-LEVEL" in exp or "MID LEVEL" in exp:
        return "MID-LEVEL"
    elif "SENIOR" in exp:
        return "SENIOR"
    else:
        raise ValueError(f"Unexpected experience level: {exp}")

# Load data with corrected SQL query
df = load_developer_data()
if df is None or df.empty:
    print("Exiting script due to data loading failure or no valid experience levels.")
    exit()

# Preprocess data
df['languages'] = df['languages'].fillna("").str.split(', ')
df['languages'] = df['languages'].apply(lambda x: [lang.strip().upper() for lang in x if lang.strip()])
df['experience_level'] = df['experience_level'].apply(normalize_experience_level)

# Map experience levels to numeric priorities
EXPERIENCE_PRIORITY = {'SENIOR': 3, 'MID-LEVEL': 2, 'JUNIOR': 1}
df['experience_priority'] = df['experience_level'].map(EXPERIENCE_PRIORITY)

# Encode languages using MultiLabelBinarizer
mlb = MultiLabelBinarizer(classes=sorted(set(lang for sublist in df['languages'] for lang in sublist)))
languages_encoded = mlb.fit_transform(df['languages'])
df_languages = pd.DataFrame(languages_encoded, columns=mlb.classes_)

# Prepare input (X) and output (y)
X = pd.concat([df['experience_priority'], df_languages], axis=1)
y = df['developer_name']

# Split dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train a RandomForestClassifier
model = RandomForestClassifier(random_state=42)
model.fit(X_train, y_train)

def extract_features_from_text(text):
    """
    Extract programming languages and experience level from input text.
    """
    text = text.upper()  # Convert to uppercase for consistency
    languages_pattern = r"(" + "|".join(re.escape(lang) for lang in mlb.classes_) + r")"
    experience_pattern = r"(" + "|".join(EXPERIENCE_PRIORITY.keys()) + r")"

    languages = re.findall(languages_pattern, text)
    experience = re.findall(experience_pattern, text)

    if not experience:
        raise ValueError("Experience level not found in the input. Please specify 'Junior', 'Mid-Level', or 'Senior'.")

    if not languages:
        raise ValueError("No programming languages found in the input text. Please specify at least one valid programming language.")

    return list(set(languages)), experience[0]  # Remove duplicate languages

def find_top_5_developers(text):
    """
    Find the top 5 developers based on client input, filtering by experience and required languages.
    """
    languages_input, experience_input = extract_features_from_text(text)

    # Encode the new input
    exp_priority = EXPERIENCE_PRIORITY[experience_input]
    new_input_encoded_languages = mlb.transform([languages_input])
    new_input_encoded_languages = pd.DataFrame(new_input_encoded_languages, columns=mlb.classes_)

    # Create a single input DataFrame for prediction
    new_input_encoded = pd.concat(
        [pd.DataFrame({'experience_priority': [exp_priority]}), new_input_encoded_languages],
        axis=1
    )

    # Ensure columns match the training data
    for col in X.columns:
        if col not in new_input_encoded:
            new_input_encoded[col] = 0  # Add missing columns with default value 0

    new_input_encoded = new_input_encoded[X.columns]  # Reorder columns to match the training data

    # Predict probabilities for all developers
    probabilities = model.predict_proba(new_input_encoded)[0]
    developer_probabilities = []

    # Filter developers by experience level and required languages
    for developer, prob in zip(model.classes_, probabilities):
        dev_row = df[df['developer_name'] == developer]
        if dev_row.empty:
            continue
        dev_experience = dev_row['experience_level'].values[0]
        dev_languages = dev_row['languages'].values[0]

        # Check if the developer knows all required languages
        if EXPERIENCE_PRIORITY[dev_experience] <= exp_priority and set(languages_input).issubset(dev_languages):
            developer_probabilities.append((developer, prob * 100, dev_experience, ", ".join(dev_languages)))

    # Sort by experience priority first, then by probability
    developer_probabilities.sort(key=lambda x: (-EXPERIENCE_PRIORITY[x[2]], -x[1]))

    return developer_probabilities[:5]

# Main Script
try:
    client_input = input("Enter the type of developer you're looking for (e.g., 'I need a Senior Developer with experience in Python, Java, and React'): ").upper()
    top_matches = find_top_5_developers(client_input)

    # Display the top 5 matches
    if top_matches:
        print("Top 5 matches:")
        for dev, pct, exp, langs in top_matches:
            print(f"{dev}: {pct:.2f}% (Experience: {exp}, Languages: {langs})")
    else:
        print("No developers matched your criteria.")
except ValueError as e:
    print(f"Error: {e}")
