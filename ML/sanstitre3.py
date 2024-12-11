# Example input answers from the questionnaire
input_answers = {
    "objective": "Attract customers/users",
    "technologies": "No preference",
    "budget": "Medium budget (1000€ - 5000€)",
    "color_palette": "Custom color palette",
    "design": "Modern design focusing on aesthetics",
    "structure": "Custom layout with specific functionalities",
    "interview": "Yes"
}

# Function to generate app description using a template
def generate_app_description(input_answers):
    description = f"This application is designed to {input_answers['objective'].lower()}, making it a valuable tool for achieving business goals.\n"
    description += f"The project has a {input_answers['budget']}, ensuring an optimal balance between cost and functionality.\n"
    
    if input_answers["technologies"] == "No preference":
        description += "The client has no specific preferences for technologies, allowing flexibility in choosing development tools.\n"
    else:
        description += f"The preferred technologies for this app are {input_answers['technologies']}.\n"
    
    description += f"The app will feature a {input_answers['color_palette']}, emphasizing a {input_answers['design']}.\n"
    description += f"The structure will include a {input_answers['structure']}, tailored to meet user-specific needs and enhance the overall experience.\n"
    
    if input_answers["interview"] == "Yes":
        description += "An interview with the developer will be conducted to align the project with the client's vision.\n"
    else:
        description += "No developer interview is planned for this project.\n"
    
    return description

# Generate the description
app_description = generate_app_description(input_answers)

# Output the description
print("App Description:")
print(app_description)
