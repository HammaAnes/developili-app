-- Table User (Tracks all users)
CREATE TABLE "User" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(150) UNIQUE NOT NULL,
    email VARCHAR(254) UNIQUE NOT NULL,
    password VARCHAR(128) NOT NULL,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    role TEXT CHECK (role IN ('client', 'developer', 'admin')) DEFAULT 'client',
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Table ClientProfile (Details for client users)
CREATE TABLE ClientProfile (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    description TEXT,
    profile_picture TEXT NULL, -- Profile picture storage
    preferences JSONB -- Stores user-specific preferences
);

-- Table DeveloperProfile (Details for developer users)
CREATE TABLE DeveloperProfile (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    skills TEXT,
    availability TEXT,
    rating FLOAT DEFAULT 0 CHECK (rating BETWEEN 0 AND 5),
    profile_picture TEXT NULL, -- Profile picture storage
    accomplishments JSONB -- Stores accomplished project details
);
-- Table RegistrationDetails (Tracks user registration sources)
CREATE TABLE RegistrationDetails (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    developer BOOLEAN DEFAULT FALSE,
    registration_source TEXT CHECK (registration_source IN ('Google', 'Apple', 'Manual')) DEFAULT 'Manual'
);

-- Wallet Table (Tracks user wallet and transaction history)
CREATE TABLE Wallet (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    balance NUMERIC(10, 2) DEFAULT 0, -- User's wallet balance
    last_recharge TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Tracks last recharge
);

-- Transactions Table (Logs wallet transactions)
CREATE TABLE Transactions (
    id SERIAL PRIMARY KEY,
    wallet_id INT NOT NULL REFERENCES Wallet(id) ON DELETE CASCADE,
    transaction_type TEXT CHECK (transaction_type IN ('credit', 'debit')) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    description TEXT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table Projects (Tracks all projects)
CREATE TABLE Projects (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES ClientProfile(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status TEXT CHECK (status IN ('pending', 'in_progress', 'completed')) DEFAULT 'pending',
    technologies JSONB NULL, -- List of technologies used
    team_members JSONB NULL, -- List of team members
    duration TEXT NULL, -- Duration of the project
    users INT DEFAULT 0, -- Total users impacted
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table Questionnaire (Dynamic questionnaire for projects)
CREATE TABLE Questionnaire (
    id SERIAL PRIMARY KEY,
    question TEXT NOT NULL,
    question_type TEXT CHECK (question_type IN ('multiple_choice', 'text', 'rating', 'boolean', 'color_picker', 'layout_selector')) DEFAULT 'text',
    options JSONB, -- Stores multiple-choice options
    step INT NOT NULL DEFAULT 1, -- Groups questions by UI step
    category TEXT CHECK (category IN ('general', 'SRS', 'interview', 'design')) DEFAULT 'general'
);
-- Table QuestionResponseMapping (Maps client responses to questions)
CREATE TABLE QuestionResponseMapping (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES ClientProfile(id) ON DELETE CASCADE,
    question_id INT NOT NULL REFERENCES Questionnaire(id) ON DELETE CASCADE,
    response TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- DeveloperRating Table (Tracks ratings for developers)
CREATE TABLE DeveloperRating (
    id SERIAL PRIMARY KEY,
    developer_id INT NOT NULL REFERENCES DeveloperProfile(id) ON DELETE CASCADE,
    project_id INT NOT NULL REFERENCES Projects(id) ON DELETE CASCADE,
    rating FLOAT CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    comment TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Payments Table (Manages payment transactions)
CREATE TABLE Payments (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Projects(id) ON DELETE CASCADE,
    client_id INT NOT NULL REFERENCES ClientProfile(id) ON DELETE CASCADE,
    developer_id INT NOT NULL REFERENCES DeveloperProfile(id) ON DELETE CASCADE,
    amount NUMERIC(10, 2) NOT NULL,
    status TEXT CHECK (status IN ('pending', 'completed', 'failed')) DEFAULT 'pending',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method TEXT CHECK (payment_method IN ('credit_card', 'paypal', 'wallet')) NOT NULL
);

-- Chat Table (Tracks messaging interactions)
CREATE TABLE Chat (
    id SERIAL PRIMARY KEY,
    sender_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    receiver_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    message_type TEXT CHECK (message_type IN ('text', 'file', 'image')) DEFAULT 'text',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE
);

-- Notifications Table (Tracks user notifications)
CREATE TABLE Notifications (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sidebar Preferences Table (User-specific sidebar configurations)
CREATE TABLE SidebarPreferences (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    active_tab TEXT CHECK (active_tab IN ('dashboard', 'projects', 'payments', 'help_support', 'settings')) DEFAULT 'dashboard',
    customization JSONB NULL -- Stores UI preferences like color themes, layouts
);

-- QuickActions Table (Tracks user-defined quick actions)
CREATE TABLE QuickActions (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    action_type TEXT CHECK (action_type IN ('start_project', 'request_consultation', 'view_proposals', 'wallet_access')) NOT NULL,
    action_name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Recharge Codes Table (Manages wallet recharge codes)
CREATE TABLE RechargeCodes (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "User"(id) ON DELETE CASCADE,
    code TEXT NOT NULL,
    status TEXT CHECK (status IN ('unused', 'used')) DEFAULT 'unused',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    used_at TIMESTAMP NULL -- When the code was used
);

-- Collaboration Notes Table (Tracks collaboration details)
CREATE TABLE CollaborationNotes (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Projects(id) ON DELETE CASCADE,
    communication_style TEXT CHECK (communication_style IN ('detailed', 'occasional', 'major_changes')) NOT NULL,
    preferred_approach TEXT NULL,
    recurring_meetings BOOLEAN DEFAULT FALSE, -- Indicates recurring collaborations
    additional_notes TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Profile Projects Table (Tracks developer-accomplished projects)
CREATE TABLE ProfileProjects (
    id SERIAL PRIMARY KEY,
    developer_id INT NOT NULL REFERENCES DeveloperProfile(id) ON DELETE CASCADE,
    project_name TEXT NOT NULL,
    specialization TEXT NOT NULL,
    technologies JSONB NULL,
    start_date DATE NULL,
    end_date DATE NULL
);

-- Budget Overview Table (Tracks project budgets)
CREATE TABLE BudgetOverview (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Projects(id) ON DELETE CASCADE,
    budget_allocated NUMERIC(10, 2) NOT NULL,
    budget_spent NUMERIC(10, 2) DEFAULT 0,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table ProjectObjectives (Tracks project objectives)
CREATE TABLE ProjectObjectives (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Projects(id) ON DELETE CASCADE,
    objective_type TEXT CHECK (objective_type IN ('attract_customers', 'improve_productivity', 'launch_product', 'other')) NOT NULL,
    description TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table ProjectBudget (Tracks project budget details)
CREATE TABLE ProjectBudget (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Projects(id) ON DELETE CASCADE,
    budget_range TEXT CHECK (budget_range IN ('small', 'medium', 'large')) NOT NULL,
    budget_value NUMERIC(10, 2) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table ProjectDesign (Tracks project design preferences)
CREATE TABLE ProjectDesign (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Projects(id) ON DELETE CASCADE,
    color_palette JSONB NULL, -- Stores color palette preferences
    layout_preferences TEXT NULL, -- Stores selected layout preferences
    additional_notes TEXT NULL, -- Stores additional design notes
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Developer Preferences Table (Tracks client preferences for developers)
CREATE TABLE DeveloperPreferences (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES ClientProfile(id) ON DELETE CASCADE,
    preferred_developers JSONB NULL, -- List of developer preferences
    interview_required BOOLEAN DEFAULT FALSE, -- Whether an interview is needed
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table ProjectReferences (Tracks project references)
CREATE TABLE ProjectReferences (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Projects(id) ON DELETE CASCADE,
    reference_link TEXT NULL, -- Link or name of similar applications
    description TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Application Features Table (Tracks application features)
CREATE TABLE ApplicationFeatures (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Projects(id) ON DELETE CASCADE,
    feature_type TEXT CHECK (feature_type IN ('core', 'optional')) NOT NULL,
    feature_description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Feedback Table (Tracks project feedback)
CREATE TABLE Feedback (
    id SERIAL PRIMARY KEY,
    project_id INT NOT NULL REFERENCES Projects(id) ON DELETE CASCADE,
    feedback_text TEXT NOT NULL,
    feedback_type TEXT CHECK (feedback_type IN ('frequent', 'milestone', 'trust')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Communication Preferences Table (Tracks client communication preferences)
CREATE TABLE CommunicationPreferences (
    id SERIAL PRIMARY KEY,
    client_id INT NOT NULL REFERENCES ClientProfile(id) ON DELETE CASCADE,
    preferred_method TEXT CHECK (preferred_method IN ('email', 'phone_calls', 'video_meetings', 'messaging_apps')) NOT NULL,
    expected_response_time TEXT CHECK (expected_response_time IN ('few_hours', 'end_of_day', '24_48_hours', 'flexible')) NOT NULL,
    detailed_notes TEXT NULL -- Long-term communication notes
);

-- Calendar Table (Tracks developer availability)
CREATE TABLE Calendar (
    id SERIAL PRIMARY KEY,
    developer_id INT NOT NULL REFERENCES DeveloperProfile(id) ON DELETE CASCADE,
    unavailable_start DATE NOT NULL,
    unavailable_end DATE NOT NULL
);
