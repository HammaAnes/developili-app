-- User Table
CREATE TABLE "User" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(150) UNIQUE NOT NULL,
    email VARCHAR(254) UNIQUE NOT NULL,
    password VARCHAR(128) NOT NULL,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    role TEXT CHECK (role IN ('client', 'developer')) DEFAULT 'client',
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Client Profile Table
CREATE TABLE ClientProfile (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    description TEXT,
    profile_picture TEXT NULL -- Profile picture storage
);

-- Developer Profile Table
CREATE TABLE DeveloperProfile (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    skills TEXT,
    availability TEXT,
    rating FLOAT DEFAULT 0 CHECK (rating BETWEEN 0 AND 5),
    profile_picture TEXT NULL -- Profile picture storage
);

-- Registration Details Table
CREATE TABLE RegistrationDetails (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    developer BOOLEAN DEFAULT FALSE,
    registration_source TEXT CHECK (registration_source IN ('Google', 'Apple', 'Manual')) DEFAULT 'Manual'
);

-- Questionnaire Table
CREATE TABLE Questionnaire (
    id SERIAL PRIMARY KEY,
    question TEXT NOT NULL,
    question_type TEXT CHECK (question_type IN ('multiple_choice', 'text', 'rating', 'boolean', 'color_picker', 'layout_selector')) DEFAULT 'text',
    options JSONB, -- Stores multiple-choice options
    step INT NOT NULL DEFAULT 1, -- Groups questions by UI step
    category TEXT CHECK (category IN ('general', 'SRS', 'interview', 'design')) DEFAULT 'general'
);

-- Question Response Mapping Table
CREATE TABLE QuestionResponseMapping (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES ClientProfile(id) ON DELETE CASCADE,
    question_id INT NOT NULL REFERENCES Questionnaire(id) ON DELETE CASCADE,
    response TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Project Table
CREATE TABLE Project (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES ClientProfile(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status TEXT CHECK (status IN ('pending', 'in_progress', 'completed')) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Project Objectives Table
CREATE TABLE ProjectObjectives (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Project(id) ON DELETE CASCADE,
    objective_type TEXT CHECK (objective_type IN ('attract_customers', 'improve_productivity', 'launch_product', 'other')) NOT NULL,
    description TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Project Budget Table
CREATE TABLE ProjectBudget (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Project(id) ON DELETE CASCADE,
    budget_range TEXT CHECK (budget_range IN ('small', 'medium', 'large')) NOT NULL,
    budget_value NUMERIC(10, 2) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Project Design Preferences Table
CREATE TABLE ProjectDesign (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Project(id) ON DELETE CASCADE,
    color_palette JSONB NULL, -- Stores color palette preferences
    layout_preferences TEXT NULL, -- Stores selected layout preferences
    additional_notes TEXT NULL, -- Stores additional design notes
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Developer Preferences Table
CREATE TABLE DeveloperPreferences (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES ClientProfile(id) ON DELETE CASCADE,
    preferred_developers JSONB NULL, -- List of developer preferences
    interview_required BOOLEAN DEFAULT FALSE, -- Whether an interview is needed
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Project References Table
CREATE TABLE ProjectReferences (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Project(id) ON DELETE CASCADE,
    reference_link TEXT NULL, -- Link or name of similar applications
    description TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Collaboration Notes Table
CREATE TABLE CollaborationNotes (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Project(id) ON DELETE CASCADE,
    communication_style TEXT CHECK (communication_style IN ('detailed', 'occasional', 'major_changes')) NOT NULL,
    preferred_approach TEXT NULL,
    additional_notes TEXT NULL, -- Notes for long-term collaboration
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Application Features Table
CREATE TABLE ApplicationFeatures (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Project(id) ON DELETE CASCADE,
    feature_type TEXT CHECK (feature_type IN ('core', 'optional')) NOT NULL,
    feature_description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Feedback Table
CREATE TABLE Feedback (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Project(id) ON DELETE CASCADE,
    feedback_text TEXT NOT NULL,
    feedback_type TEXT CHECK (feedback_type IN ('frequent', 'milestone', 'trust')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Communication Preferences Table
CREATE TABLE CommunicationPreferences (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES ClientProfile(id) ON DELETE CASCADE,
    preferred_method TEXT CHECK (preferred_method IN ('email', 'phone_calls', 'video_meetings', 'messaging_apps')) NOT NULL,
    expected_response_time TEXT CHECK (expected_response_time IN ('few_hours', 'end_of_day', '24_48_hours', 'flexible')) NOT NULL,
    detailed_notes TEXT NULL -- Long-term communication notes
);

-- Notification Table
CREATE TABLE Notification (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Calendar Table
CREATE TABLE Calendar (
    id SERIAL PRIMARY KEY,
    developer_id INT NOT NULL REFERENCES DeveloperProfile(id) ON DELETE CASCADE,
    unavailable_start DATE NOT NULL,
    unavailable_end DATE NOT NULL
);
