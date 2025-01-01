import pandas as pd
import dask.dataframe as dd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import MultiLabelBinarizer, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
import re
import numpy as np

# Load dataset from Excel file
def load_dataset(file_path):
    """
    Reads the dataset from the specified Excel file.
    The file should contain columns: Developer Name, Languages, Experience Level.
    """
    return pd.read_excel(file_path)

# Specify the path to the Excel file
file_path = "/mnt/data/developers_data_with_names.xlsx"
df = load_dataset(file_path)

# Supported languages and experience levels
LANGUAGES = ['Python', 'Java', 'JavaScript', 'C++', 'Go', 'Swift', 'Ruby', 'PHP', 
             'TypeScript', 'SQL', 'C#', 'HTML', 'CSS', 'React', 'Node.js', 'Rust', 
             'Scala', 'R', 'Objective-C', 'Perl', 'Dart']
EXPERIENCE_LEVELS = ['Junior', 'Mid', 'Senior']

# Categories based on programming languages
CATEGORIES = {
    'frontend': ['JavaScript', 'HTML', 'CSS', 'React', 'TypeScript', 'Node.js'],
    'backend': ['Python', 'Java', 'C++', 'Go', 'PHP', 'Rust', 'Scala'],
    'database': ['SQL', 'R', 'Perl'],
    'ai': ['Python', 'R', 'Scala']
}

# Encode languages using MultiLabelBinarizer
mlb = MultiLabelBinarizer(classes=LANGUAGES)
languages_encoded = mlb.fit_transform(df['Languages'].str.split(', '))
df_languages = pd.DataFrame(languages_encoded, columns=mlb.classes_)

# Encode experience levels using OneHotEncoder
experience_encoder = OneHotEncoder(sparse_output=False, handle_unknown='ignore')
experience_encoded = experience_encoder.fit_transform(df[['Experience Level']])
df_experience = pd.DataFrame(experience_encoded, columns=experience_encoder.get_feature_names_out(['Experience Level']))

# Combine encoded languages and experience level
preprocessed_df = pd.concat([df_experience, df_languages], axis=1)

# Define column transformer for preprocessing
preprocessor = ColumnTransformer(
    transformers=[
        ('experience', experience_encoder, df_experience.columns),
        ('languages', 'passthrough', df_languages.columns)
    ])

# Prepare input (X) and output (y)
X = preprocessed_df
y = df['Developer Name']

# Split dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Build the model pipeline
model = Pipeline([
    ('preprocessor', preprocessor),
    ('classifier', RandomForestClassifier(random_state=42))
])

# Train the model
model.fit(X_train, y_train)

# Function to find the top developers for a specific category
def find_top_developers_by_category(category, top_n=5):
    if category not in CATEGORIES:
        print(f"Category '{category}' is not recognized.")
        return None
    
    # Get languages for the category
    category_languages = CATEGORIES[category]

    # Create encoded input for the category
    new_input_encoded_languages = mlb.transform([category_languages])
    new_input_encoded_languages = pd.DataFrame(new_input_encoded_languages, columns=mlb.classes_)
    new_input_encoded_experience = pd.DataFrame(np.zeros((1, len(df_experience.columns))), columns=df_experience.columns)
    new_input_encoded = pd.concat([new_input_encoded_experience, new_input_encoded_languages], axis=1)

    # Ensure columns match the training data
    for col in preprocessed_df.columns:
        if col not in new_input_encoded:
            new_input_encoded[col] = 0

    new_input_encoded = new_input_encoded[preprocessed_df.columns]

    # Preprocess the input to match training format
    new_input_transformed = preprocessor.transform(new_input_encoded)

    # Get probabilities for all developers
    probabilities = model.named_steps['classifier'].predict_proba(new_input_transformed)
    top_indices = np.argsort(probabilities[0])[-top_n:][::-1]
    top_developers = [(model.named_steps['classifier'].classes_[i], probabilities[0][i] * 100) for i in top_indices]

    return top_developers

# Display top developers for each category
categories = ['frontend', 'backend', 'database', 'ai']
for category in categories:
    print(f"Top 5 developers for {category.capitalize()}:")
    top_devs = find_top_developers_by_category(category)
    if top_devs:
        for dev, pct in top_devs:
            print(f"{dev}: {pct:.2f}%")
    print()
