-- Table Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('client', 'developer') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table ClientProfile
CREATE TABLE ClientProfile (
    client_id INT PRIMARY KEY,
    description TEXT,
    FOREIGN KEY (client_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table DeveloperProfile
CREATE TABLE DeveloperProfile (
    developer_id INT PRIMARY KEY,
    skills TEXT,
    availability TEXT,
    rating FLOAT DEFAULT 0 CHECK (rating BETWEEN 0 AND 5),
    FOREIGN KEY (developer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table Projects
CREATE TABLE Projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table Questionnaire
CREATE TABLE Questionnaire (
    questionnaire_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    question VARCHAR(255) NOT NULL,
    answer TEXT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);

-- Table Proposals
CREATE TABLE Proposals (
    proposal_id INT PRIMARY KEY AUTO_INCREMENT,
    developer_id INT NOT NULL,
    project_id INT NOT NULL,
    proposal_text TEXT,
    proposed_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (developer_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);

-- Table Contracts
CREATE TABLE Contracts (
    contract_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    developer_id INT NOT NULL,
    final_price DECIMAL(10, 2) NOT NULL,
    deadline DATE NOT NULL,
    deliverables ENUM('application', 'source_code', 'admin_rights') NOT NULL,
    maintenance_option ENUM('none', 'occasional', 'continuous') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (developer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table Messages
CREATE TABLE Messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table Reviews
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    reviewer_id INT NOT NULL,
    reviewed_user_id INT NOT NULL,
    project_id INT NOT NULL,
    rating FLOAT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reviewer_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewed_user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);

-- Table Notifications
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table Calendar (for developer availability)
CREATE TABLE Calendar (
    calendar_id INT PRIMARY KEY AUTO_INCREMENT,
    developer_id INT NOT NULL,
    unavailable_start DATE NOT NULL,
    unavailable_end DATE NOT NULL,
    FOREIGN KEY (developer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Table ProjectRequirements (Detailed project specifications)
CREATE TABLE ProjectRequirements (
    requirement_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    requirement TEXT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);

-- Table ProjectPreferences (Optional preferences for client-developer collaboration)
CREATE TABLE ProjectPreferences (
    preference_id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    preference TEXT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE
);
