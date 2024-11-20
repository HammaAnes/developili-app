import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import MultiLabelBinarizer, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
import re

data = {
    'Developer Name': ['John Doe', 'Jane Smith', 'Mark Lee', 'Mary Johnson'],
    'Languages': [['Python', 'JavaScript', 'SQL'], ['Java', 'Ruby', 'C#'], ['Go', 'Python', 'SQL'], ['JavaScript', 'TypeScript', 'React']],
    'Experience Level': ['Senior', 'Mid', 'Mid', 'Junior']
}

df = pd.DataFrame(data)

languages_list = ['Python', 'Java', 'JavaScript', 'C++', 'Go', 'Swift', 'Ruby', 'PHP', 'TypeScript', 'SQL', 'C#', 'HTML', 'CSS', 'React', 'Node.js', 'Rust', 'Scala', 'R', 'Objective-C', 'Perl', 'Dart']

mlb = MultiLabelBinarizer(classes=languages_list)
languages_encoded = mlb.fit_transform(df['Languages'])
df_languages = pd.DataFrame(languages_encoded, columns=mlb.classes_)

experience_encoder = OneHotEncoder(sparse_output=False, handle_unknown='ignore')

df_combined = pd.concat([df[['Experience Level']], df_languages], axis=1)

preprocessor = ColumnTransformer(
    transformers=[
        ('experience', experience_encoder, ['Experience Level']),
        ('languages', 'passthrough', df_languages.columns)
    ])

X = df_combined.drop('Developer Name', axis=1, errors='ignore')
y = df['Developer Name']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

model = Pipeline([
    ('preprocessor', preprocessor),
    ('classifier', RandomForestClassifier())
])

model.fit(X_train, y_train)

def extract_features_from_text(text):
    languages_pattern = r"(Python|Java|JavaScript|C\+\+|Go|Swift|Ruby|PHP|TypeScript|SQL|C#|HTML|CSS|React|Node\.js|Rust|Scala|R|Objective\-C|Perl|Dart)"
    experience_pattern = r"(Junior|Mid|Senior)"
    
    languages = re.findall(languages_pattern, text)
    experience = re.findall(experience_pattern, text)
    
    if not experience:
        experience = ['Junior']
    
    return languages, experience[0]

def find_best_developer_for_client_search(text):
    languages_input, experience_input = extract_features_from_text(text)
    
    if not languages_input:
        print("No programming languages found in the input text.")
        return None
    
    new_input_encoded = mlb.transform([languages_input])
    new_input_encoded = pd.DataFrame(new_input_encoded, columns=mlb.classes_)
    
    new_input_encoded['Experience Level'] = experience_input
    
    predicted_developer = model.predict(new_input_encoded)

    return predicted_developer[0]

client_input = input("Please enter the type of developer you're looking for (e.g., 'I need a Senior Backend Developer with experience in Python and JavaScript'): ")
best_match = find_best_developer_for_client_search(client_input)

if best_match:
    print(f"Best match: {best_match}")
