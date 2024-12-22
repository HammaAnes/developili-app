-- User Table
CREATE TABLE User (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(150) UNIQUE NOT NULL,
    email VARCHAR(254) UNIQUE NOT NULL,
    password VARCHAR(128) NOT NULL,
    first_name VARCHAR(30) NULL,
    last_name VARCHAR(30) NULL,
    role ENUM('client', 'developer') DEFAULT 'client',
    date_joined DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Client Profile Table
CREATE TABLE ClientProfile (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    description TEXT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
);

-- Developer Profile Table
CREATE TABLE DeveloperProfile (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    skills TEXT NULL,
    availability TEXT NULL,
    rating FLOAT DEFAULT 0 CHECK (rating BETWEEN 0 AND 5),
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
);

-- Questionnaire Table
CREATE TABLE Questionnaire (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question TEXT NOT NULL,
    question_type ENUM('multiple_choice', 'text', 'rating', 'boolean') NOT NULL DEFAULT 'text',
    options JSON NULL
);

-- Question Response Mapping Table
CREATE TABLE QuestionResponseMapping (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    question_id INT NOT NULL,
    response TEXT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES ClientProfile(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES Questionnaire(id) ON DELETE CASCADE
);

-- Project Table
CREATE TABLE Project (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NULL,
    status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES ClientProfile(id) ON DELETE CASCADE
);

-- Project Preferences Table
CREATE TABLE ProjectPreferences (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    preference_category VARCHAR(50) NOT NULL,
    preference_value TEXT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES ClientProfile(id) ON DELETE CASCADE
);

-- Proposal Table
CREATE TABLE Proposal (
    id INT PRIMARY KEY AUTO_INCREMENT,
    developer_id INT NOT NULL,
    project_id INT NOT NULL,
    proposal_text TEXT NOT NULL,
    proposed_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (developer_id) REFERENCES DeveloperProfile(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Project(id) ON DELETE CASCADE
);

-- Contract Table
CREATE TABLE Contract (
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    developer_id INT NOT NULL,
    final_price DECIMAL(10, 2) NOT NULL,
    deadline DATE NOT NULL,
    deliverables JSON NOT NULL, -- E.g., ["application", "source_code"]
    maintenance_option ENUM('none', 'occasional', 'continuous') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES Project(id) ON DELETE CASCADE,
    FOREIGN KEY (developer_id) REFERENCES DeveloperProfile(id) ON DELETE CASCADE
);

-- Message Table
CREATE TABLE Message (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES User(id) ON DELETE CASCADE
);

-- Review Table
CREATE TABLE Review (
    id INT PRIMARY KEY AUTO_INCREMENT,
    reviewer_id INT NOT NULL,
    reviewed_user_id INT NOT NULL,
    project_id INT NOT NULL,
    rating FLOAT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reviewer_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (reviewed_user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Project(id) ON DELETE CASCADE
);

-- Notification Table
CREATE TABLE Notification (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
);

-- Calendar Table
CREATE TABLE Calendar (
    id INT PRIMARY KEY AUTO_INCREMENT,
    developer_id INT NOT NULL,
    unavailable_start DATE NOT NULL,
    unavailable_end DATE NOT NULL,
    FOREIGN KEY (developer_id) REFERENCES DeveloperProfile(id) ON DELETE CASCADE
);

-- Project Requirements Table
CREATE TABLE ProjectRequirements (
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    requirement TEXT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES Project(id) ON DELETE CASCADE
);

-- Communication Preferences Table
CREATE TABLE CommunicationPreferences (
    id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    preferred_method ENUM('email', 'phone_calls', 'video_meetings', 'messaging_apps') NOT NULL,
    expected_response_time ENUM('few_hours', 'end_of_day', '24_48_hours', 'flexible') NOT NULL,
    FOREIGN KEY (client_id) REFERENCES ClientProfile(id) ON DELETE CASCADE
);
