#Online Learning platform 

create database if not exists OnlineLearningPlatform;  
show databases;  
use OnlineLEarningPlatform;  
select database(); 

-- Roles Tables
CREATE TABLE IF NOT EXISTS roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL
);
-- insert record into roles 
INSERT INTO roles (role_name) VALUES
('Admin'), ('Instructor'), ('Student');
select * from roles;

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);
-- insert record into users 
INSERT INTO users (name, email, password, role_id) VALUES
('Alice Johnson', 'alice@example.com', 'hashed_pass1', 2),
('Bob Smith', 'bob@example.com', 'hashed_pass2', 3),
('Carol White', 'carol@example.com', 'hashed_pass3', 1),
('David Green', 'david@example.com', 'hashed_pass4', 2),
('Eva Brown', 'eva@example.com', 'hashed_pass5', 3),
('Frank Black', 'frank@example.com', 'hashed_pass6', 2),
('Grace Lee', 'grace@example.com', 'hashed_pass7', 3),
('Henry Moore', 'henry@example.com', 'hashed_pass8', 2),
('Ivy Taylor', 'ivy@example.com', 'hashed_pass9', 1),
('Jack Wilson', 'jack@example.com', 'hashed_pass10', 3);
select * from users;

-- Quizzes tables
CREATE TABLE quizzes (
    quiz_id INT AUTO_INCREMENT PRIMARY KEY,
    module_id INT,
    title VARCHAR(100),
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);
-- Insert records into quizzes
INSERT INTO quizzes (module_id, title) VALUES
(1, 'Python Basics Quiz'),
(2, 'HTML & CSS Quiz'),
(3, 'Excel Fundamentals Quiz'),
(4, 'Intro to AI Quiz'),
(5, 'SEO Concepts Quiz'),
(6, 'Cybersecurity Basics Quiz'),
(7, 'AWS Cloud Quiz'),
(8, 'Flutter Basics Quiz'),
(9, 'UI/UX Design Quiz'),
(10, 'DevOps Foundations Quiz');

-- Projects Table

CREATE TABLE IF NOT EXISTS projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    module_id INT, -- Optional: if project is part of a specific module
    project_title VARCHAR(255) NOT NULL,
    description TEXT,
    due_date DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);
-- insert record to projects
INSERT INTO projects (course_id, module_id, project_title, description, due_date) VALUES
(1, 1, 'Python CLI Calculator', 'Build a small CLI-based calculator using Python basics.', '2025-12-01'),
(1, 2, 'Control Flow Challenge', 'Create a number guessing game using loops and conditions.', '2025-12-02'),
(1, 3, 'Data Structure Quiz App', 'Develop a quiz app using lists and dictionaries.', '2025-12-03'),

(2, 4, 'JS Form Validator', 'Create a form validation app using JavaScript functions.', '2025-12-04'),
(2, 5, 'Interactive Web Page', 'Use DOM manipulation to build an interactive webpage.', '2025-12-05'),

(3, 6, 'Tableau Data Prep', 'Clean and join datasets using Tableau.', '2025-12-06'),
(3, 7, 'Worksheet Insights', 'Build insightful bar and line charts.', '2025-12-07'),
(3, 8, 'Dashboard Storytelling', 'Combine worksheets into a dashboard with story points.', '2025-12-08'),

(4, 9, 'ML Concept Presentation', 'Prepare a presentation on types of machine learning.', '2025-12-09'),
(4, 10, 'Regression Model in Excel', 'Create a basic linear regression model using sample data.', '2025-12-10');

-- Grades Table 
CREATE TABLE IF NOT EXISTS grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    module_id INT, -- Optional
    project_id INT NOT NULL, -- Required
    grade DECIMAL(5,2) NOT NULL, -- e.g., 95.50
    grade_type VARCHAR(50) DEFAULT 'project', -- fixed as 'project'
    remarks TEXT,
    graded_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);
-- insert reocrd to grades
select * from grades;
INSERT INTO grades (user_id, course_id, module_id, project_id, grade, remarks) VALUES
(2, 1, 1, 11, 92.5, 'Well-structured Python code'),
(2, 4, 9, 19, 88.0, 'Good concept but needed more technical depth'),
(5, 1, 2, 12, 95.0, 'Excellent control flow design'),
(5, 5, 11, 15, 90.0, 'Great analysis and on-page SEO improvements'),
(5, 6, 12, 16, 87.5, 'Good research on breach report'),
(7, 1, 3, 13, 94.0, 'Interactive quiz app using data structures'),
(7, 7, 13, 17, 91.0, 'EC2 deployment worked perfectly'),
(10, 3, 8, 18, 96.5, 'Accurate dashboard storytelling'),
(10, 9, 15, 20, 89.0, 'Strong regression analysis'),
(10, 2, 5, 14, 90.5, 'Functional JavaScript form validation');

-- Courses Table
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    category_id INT,
    created_by INT,
    FOREIGN KEY (category_id) REFERENCES course_categories(category_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

INSERT INTO courses (title, description, category_id, created_by)
VALUES
('Introduction to Python for Data Science', 'Learn Python basics, Pandas, and NumPy.', 1, 1),
('Modern JavaScript (ES6+)', 'Deep dive into new JavaScript features.', 2, 2),
('Data Visualization with Tableau', 'Create impactful dashboards and reports.', 3, 3),
('Machine Learning Foundations', 'Understand core ML algorithms like regression and classification.', 4, 4),
('SEO & Content Marketing Strategy', 'Drive organic traffic and build brand authority.', 5, 5),
('Network Security Fundamentals', 'Learn about firewalls, VPNs, and intrusion detection.', 6, 6),
('AWS Certified Cloud Practitioner', 'A complete prep course for the AWS CCP exam.', 7, 7),
('React Native for Beginners', 'Build cross-platform mobile apps with React Native.', 8, 8),
('User Interface Design with Figma', 'From wireframes to high-fidelity prototypes.', 9, 9),
('Introduction to Docker and Kubernetes', 'Containerize and orchestrate your applications.', 10, 10),
('Advanced SQL for Analysts', 'Master window functions, CTEs, and query optimization.', 1, 3),
('ReactJS Front-End Development', 'Build dynamic user interfaces with React.', 2, 1),
('Azure Fundamentals (AZ-900)', 'Start your journey in the Microsoft Azure cloud.', 7, 4),
('Deep Learning with TensorFlow', 'Explore neural networks and deep learning concepts.', 4, 9),
('Power BI for Business Users', 'Transform data into actionable insights with Power BI.', 3, 2);

-- Select all data from the new courses table
SELECT * FROM courses;

-- Enrollment Table 
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    course_id INT,
    enrolled_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO enrollments (user_id, course_id) VALUES
(3, 1),  -- Carol (Student) on 'Intro to Python'
(5, 1),  -- Eva (Student) on 'Intro to Python'
(7, 2),  -- Grace (Student) on 'Modern JavaScript'
(3, 3),  -- Carol (Student) on 'Data Visualization with Tableau'
(5, 4),  -- Eva (Student) on 'Machine Learning Foundations'
(7, 5),  -- Grace (Student) on 'SEO & Content Marketing'
(3, 7),  -- Carol (Student) on 'AWS Certified Cloud Practitioner'
(5, 8),  -- Eva (Student) on 'React Native for Beginners'
(7, 10), -- Grace (Student) on 'Introduction to Docker'
(3, 11), -- Carol (Student) on 'Advanced SQL'
(1, 1),  -- Alice (Instructor) on 'Intro to Python' (maybe auditing)
(2, 3),  -- Bob (Student) on 'Data Visualization with Tableau'
(4, 4),  -- David (Instructor) on 'Machine Learning Foundations'
(6, 6),  -- Frank (Instructor) on 'Network Security'
(8, 8),  -- Henry (Instructor) on 'React Native'
(10, 10);-- Jack (Student) on 'Introduction to Docker'

-- Payment Table 
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'pending',  
    payment_method VARCHAR(50),                    
    transaction_id VARCHAR(100),                  
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
 
-- Insert into payments  
INSERT INTO payments (user_id, course_id, amount, payment_status, payment_method, transaction_id) VALUES
(3, 1, 199.99, 'completed', 'credit_card', 'txn_aa123bb'),
(5, 1, 199.99, 'completed', 'paypal', 'txn_cc456dd'),
(7, 2, 149.00, 'completed', 'credit_card', 'txn_ee789ff'),
(3, 3, 99.50, 'completed', 'credit_card', 'txn_gg012hh'),
(5, 4, 299.00, 'completed', 'paypal', 'txn_ii345jj'),
(7, 5, 75.00, 'pending', 'credit_card', 'txn_kk678ll'),
(3, 7, 199.00, 'completed', 'paypal', 'txn_mm901nn'),
(2, 3, 99.50, 'completed', 'credit_card', 'txn_oo234pp'),
(10, 10, 129.00, 'failed', 'credit_card', 'txn_qq567rr');

-- Modules Table 
CREATE TABLE IF NOT EXISTS modules (
    module_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    title VARCHAR(100),
    description TEXT,
    module_order INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert into modules -- 
INSERT INTO modules (course_id, title, description, module_order) VALUES
(1, 'Module 1: Python Basics', 'Variables, Data Types, and Operators', 1),
(1, 'Module 2: Control Flow', 'Loops, and Conditional Statements', 2),
(1, 'Module 3: Data Structures', 'Lists, Dictionaries, and Tuples', 3),
(2, 'Module 1: JS Fundamentals', 'Variables, Functions, and Scope', 1),
(2, 'Module 2: DOM Manipulation', 'Interacting with HTML elements', 2),
(3, 'Module 1: Connecting to Data', 'Tableau data sources and joins', 1),
(3, 'Module 2: Building Worksheets', 'Creating bar charts and line graphs', 2),
(3, 'Module 3: Dashboards', 'Combining worksheets into a dashboard', 3),
(4, 'Module 1: Intro to ML', 'What is Machine Learning?', 1),
(4, 'Module 2: Linear Regression', 'Predicting continuous values', 2);

 -- Quizzes Table 
CREATE TABLE quizzes (
    quiz_id INT AUTO_INCREMENT PRIMARY KEY,
    module_id INT,
    title VARCHAR(100),
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);
-- Insert into quizzes -- Adding quizzes for the modules created above (Module IDs 1-10) 
INSERT INTO quizzes (module_id, title) VALUES
(1, 'Python Basics Quiz'),
(2, 'Control Flow Challenge'),
(4, 'JS Fundamentals Quiz'),
(6, 'Tableau Data Sources Quiz'),
(7, 'Worksheet Building Test'),
(9, 'ML Concepts Quiz'),
(10, 'Linear Regression Quiz');

-- Certificates Table 
CREATE TABLE certificates (
    certificate_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    course_id INT,
    issued_date DATE,
    certificate_link TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert into certificates -- Issuing certificates for users who completed courses 
INSERT INTO certificates (user_id, course_id, issued_date, certificate_link) VALUES
(3, 1, '2025-10-01', '/certs/user3_course1.pdf'),
(5, 1, '2025-10-05', '/certs/user5_course1.pdf'),
(7, 2, '2025-11-01', '/certs/user7_course2.pdf'),
(3, 3, '2025-09-15', '/certs/user3_course3.pdf'),
(2, 3, '2025-09-20', '/certs/user2_course3.pdf');


-- course_categories Table 

CREATE TABLE IF NOT EXISTS course_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- insert record into course_categories  
INSERT INTO course_categories (category_name) VALUES
('Data Science'),
('Web Development'),
('Business Analytics'),
('Artificial Intelligence'),
('Digital Marketing'),
('Cybersecurity'),
('Cloud Computing'),
('Mobile App Development'),
('UI/UX Design'),
('DevOps & Automation');

--  Feedback Table  
CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    course_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert into feedback -- Adding ratings and comments from users for courses  
INSERT INTO feedback (user_id, course_id, rating, comment) VALUES
(3, 1, 5, 'Fantastic introduction to Python. Very clear!'),
(5, 1, 4, 'Good course, but Module 3 was a bit difficult.'),
(7, 2, 5, 'As a JS beginner, this was the perfect starting point.'),
(3, 3, 4, 'Great visualization examples. Highly recommend.'),
(2, 3, 5, 'Learned so much about Tableau. The instructor was great.'),
(5, 4, 5, 'The best ML course I have taken. Module 2 was excellent.');

-- Calendar Table 

CREATE TABLE IF NOT EXISTS calendar_events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_title VARCHAR(150) NOT NULL,
    event_type VARCHAR(50),             
    related_course_id INT,
    related_module_id INT,
    related_quiz_id INT,
    start_datetime DATETIME NOT NULL,
    end_datetime DATETIME,
    created_by INT,
    description TEXT,
    FOREIGN KEY (related_course_id) REFERENCES courses(course_id),
    FOREIGN KEY (related_module_id) REFERENCES modules(module_id),
    FOREIGN KEY (related_quiz_id) REFERENCES quizzes(quiz_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- Inserting records into calendar
INSERT INTO calendar_events 
(event_title, event_type, related_course_id, related_module_id, related_quiz_id, start_datetime, end_datetime, created_by, description)
VALUES
('Course Kickoff: Intro to Python', 'Course Start', 1, NULL, NULL, '2025-11-10 10:00:00', '2025-11-10 11:00:00', 1, 'Welcome session for Python learners'),
('Quiz: Python Basics Quiz', 'Quiz', 1, 1, 1, '2025-11-12 09:00:00', '2025-11-12 09:30:00', 1, 'Assessment on Python fundamentals'),
('Module Release: Machine Learning Foundations - Linear Regression', 'Module Release', 4, 10, NULL, '2025-11-15 08:00:00', NULL, 4, 'Linear Regression module available'),
('Live Session: Tableau Dashboard Building', 'Live Session', 3, 8, NULL, '2025-11-18 17:00:00', '2025-11-18 18:30:00', 3, 'Interactive dashboard creation workshop'),
('Certificate Ceremony: Data Visualization with Tableau', 'Certificate', 3, NULL, NULL, '2025-11-20 12:00:00', '2025-11-20 12:30:00', 3, 'Issuing completion certificates for Tableau course');
select * from calendar_events;

-- FAQ table

CREATE TABLE IF NOT EXISTS faqs (
    faq_id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    related_course_id INT NULL,       
    created_by INT NULL,              -- User (usually Instructor or Admin) who added it
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (related_course_id) REFERENCES courses(course_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- Inserting records into FAQ

INSERT INTO faqs (question, answer, related_course_id, created_by)
VALUES
('How do I access my course materials?', 
 'Once enrolled, go to the course dashboard and click on “Modules” to access all materials.', 
 NULL, 1),

('Is there a certificate provided after completing a course?', 
 'Yes, a digital certificate is automatically issued after you complete all course modules and quizzes.', 
 NULL, 3),

('Can I retake quizzes if I fail the first time?', 
 'Yes, you can retake each quiz up to 3 times to improve your score.', 
 1, 1),

('What is the refund policy?', 
 'You can request a full refund within 7 days of purchase if less than 20% of the course is completed.', 
 NULL, 3),

('Are live sessions recorded?', 
 'Yes, all live sessions are recorded and available for replay within 24 hours.', 
 3, 3),

('Do I need prior coding experience for the Python for Data Science course?', 
 'No, the course starts with Python basics suitable for complete beginners.', 
 1, 1),

('Will I get help if I am stuck during assignments?', 
 'Yes, you can post your query in the discussion forum or contact the instructor via the “Help” tab.', 
 4, 4);

select * from faqs;

-- messaeges table
CREATE TABLE IF NOT EXISTS messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    subject VARCHAR(150),
    message_body TEXT NOT NULL,
    sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    related_course_id INT NULL,
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES users(user_id),
    FOREIGN KEY (related_course_id) REFERENCES courses(course_id)
);

-- Inset record into messages
INSERT INTO messages (sender_id, receiver_id, subject, message_body, related_course_id)
VALUES
(1, 5, 'Welcome to Python Course', 
 'Hi Eva, welcome to the Introduction to Python course! Please check the first module before our live session.', 
 1),

(5, 1, 'Python Course Query', 
 'Hello, I had a small doubt in Module 2: Control Flow. Could you please explain loops again?', 
 1),

(2, 3, 'Tableau Dashboard Session', 
 'Hi Carol, the live Tableau Dashboard session will start at 5 PM tomorrow. Don’t forget to join on time!', 
 3),

(3, 2, 'Thanks for the Update', 
 'Thanks, I’ll make sure to attend the Tableau session.', 
 3),

(4, 7, 'Machine Learning Quiz Reminder', 
 'Hi Grace, remember to complete your ML quiz by this Friday.', 
 4),

(7, 4, 'Re: Quiz Reminder', 
 'Thank you! I’ll complete it by tomorrow.', 
 4),

(9, 10, 'UI Design Feedback', 
 'Hi Jack, your Figma prototype looks great. Let’s refine the layout in our next session.', 
 9);
select * from messages;


### -------------------- Complex Queries Examples -----------------------------------

-- 1) Courses report: enrollment count, avg rating, total revenue, instructor(s)
WITH course_revenue AS (
    SELECT
        c.course_id,
        COALESCE(SUM(p.amount), 0) AS total_revenue
    FROM courses c
    LEFT JOIN payments p ON c.course_id = p.course_id AND p.payment_status = 'completed'
    GROUP BY c.course_id
),
course_stats AS (
    SELECT
        c.course_id,
        c.title,
        cc.category_name,
        u.name AS instructor_name,
        COUNT(DISTINCT e.enrollment_id) AS enrollment_count,
        ROUND(AVG(f.rating),2) AS avg_rating
    FROM courses c
    LEFT JOIN course_categories cc ON c.category_id = cc.category_id
    LEFT JOIN users u ON c.created_by = u.user_id
    LEFT JOIN enrollments e ON c.course_id = e.course_id
    LEFT JOIN feedback f ON c.course_id = f.course_id
    GROUP BY c.course_id, c.title, cc.category_name, u.name
)
SELECT
    cs.course_id,
    cs.title,
    cs.category_name,
    cs.instructor_name,
    cs.enrollment_count,
    IFNULL(cs.avg_rating, 'N/A') AS avg_rating,
    cr.total_revenue
FROM course_stats cs
LEFT JOIN course_revenue cr ON cs.course_id = cr.course_id
ORDER BY cr.total_revenue DESC, cs.enrollment_count DESC;

-- 2) Top 3 courses by completion rate per instructor (completion rate = certificates / enrollments)
WITH per_course AS (
    SELECT
        c.course_id,
        c.title,
        c.created_by,
        u.name AS instructor_name,
        COUNT(DISTINCT e.enrollment_id) AS total_enrolled,
        COUNT(DISTINCT cert.certificate_id) AS total_certified,
        CASE 
            WHEN COUNT(DISTINCT e.enrollment_id) = 0 THEN NULL
            ELSE ROUND(100 * COUNT(DISTINCT cert.certificate_id) / COUNT(DISTINCT e.enrollment_id),2)
        END AS completion_pct
    FROM courses c
    LEFT JOIN users u ON c.created_by = u.user_id
    LEFT JOIN enrollments e ON c.course_id = e.course_id
    LEFT JOIN certificates cert ON c.course_id = cert.course_id
    GROUP BY c.course_id, c.title, c.created_by, u.name
)
SELECT course_id, title, created_by, instructor_name, total_enrolled, total_certified, completion_pct
FROM (
    SELECT
        pc.*,
        ROW_NUMBER() OVER (
            PARTITION BY pc.created_by
            ORDER BY (pc.completion_pct IS NULL), pc.completion_pct DESC
        ) AS rn
    FROM per_course pc
) t
WHERE rn <= 3
ORDER BY instructor_name, completion_pct DESC;

-- 3) Upcoming calendar events: show event, creator, enrolled count for related course and whether the event conflicts
SELECT
    ce.event_id,
    ce.event_title,
    ce.event_type,
    ce.start_datetime,
    ce.end_datetime,
    u.user_id AS created_by,
    u.name AS creator_name,
    COALESCE(ec.enrolled_count, 0) AS enrolled_count,
    CASE WHEN conflict.exists_conflict = 1 THEN 'YES' ELSE 'NO' END AS has_conflict_with_creator_other_event
FROM calendar_events ce
LEFT JOIN users u ON ce.created_by = u.user_id
LEFT JOIN (
    SELECT course_id, COUNT(*) AS enrolled_count
    FROM enrollments
    GROUP BY course_id
) ec ON ce.related_course_id = ec.course_id
LEFT JOIN (
    -- detect if this creator has another event that overlaps this event time
    SELECT 
        a.event_id,
        CASE WHEN EXISTS (
            SELECT 1
            FROM calendar_events b
            WHERE b.created_by = a.created_by
              AND b.event_id <> a.event_id
              AND (
                  (a.start_datetime BETWEEN b.start_datetime AND COALESCE(b.end_datetime, b.start_datetime))
                  OR (COALESCE(a.end_datetime, a.start_datetime) BETWEEN b.start_datetime AND COALESCE(b.end_datetime, b.start_datetime))
                  OR (b.start_datetime BETWEEN a.start_datetime AND COALESCE(a.end_datetime, a.start_datetime))
              )
        ) THEN 1 ELSE 0 END AS exists_conflict
    FROM calendar_events a
) conflict ON ce.event_id = conflict.event_id
WHERE ce.start_datetime >= NOW()
ORDER BY ce.start_datetime;


-- 4. Instructors and the Total Students Enrolled in Their Courses 

SELECT u.user_id, u.name AS instructor_name, COUNT(e.enrollment_id) AS total_students
 FROM courses c 
	JOIN users u ON c.created_by = u.user_id 
	JOIN enrollments e ON c.course_id = e.course_id 
WHERE u.role_id = 2 GROUP BY u.user_id, u.name ORDER BY total_students DESC; 


-- 5. Show each course with its instructor and number of enrolled students  

SELECT c.course_id, c.title, instructor.name AS instructor_name, COUNT(e.enrollment_id) AS student_count 
FROM courses c 
	JOIN users instructor ON c.created_by = instructor.user_id 
		LEFT JOIN enrollments e ON c.course_id = e.course_id 
GROUP BY c.course_id, c.title, instructor.name 
ORDER BY student_count DESC; 


 -- ----------------------------------Stored Procedure------------------------------------------
-- 1. Stored procedure - getStudentQuizStatus
 
DELIMITER $$
 
CREATE PROCEDURE getStudentQuizStatus(IN studentId INT)
BEGIN
    SELECT  
        u.name AS student_name,
        c.title AS course_title,
        m.title AS module_title,
        q.title AS quiz_title,
        CASE 
            WHEN ce.certificate_id IS NOT NULL THEN 'Completed'
            ELSE 'In Progress'
        END AS course_status,
        ce.issued_date AS certificate_date
    FROM users u
    LEFT JOIN certificates ce ON u.user_id = ce.user_id
    LEFT JOIN courses c ON ce.course_id = c.course_id
    LEFT JOIN modules m ON c.course_id = m.course_id
    LEFT JOIN quizzes q ON m.module_id = q.module_id
    WHERE u.user_id = studentId
    ORDER BY c.course_id, m.module_order;
END$$
 
DELIMITER ;

-- 2. Stored Procedure 
DELIMITER $$

CREATE PROCEDURE sp_EnrollUserInCourse(
    IN p_user_id INT,
    IN p_course_id INT
)
BEGIN
    DECLARE is_enrolled INT;

    -- First, check if the user is already enrolled in this course
    SELECT COUNT(*)
    INTO is_enrolled
    FROM enrollments
    WHERE user_id = p_user_id AND course_id = p_course_id;

    -- If the count is 0 (not enrolled), then insert the new record
    IF is_enrolled = 0 THEN
        INSERT INTO enrollments(user_id, course_id)
        VALUES(p_user_id, p_course_id);
    ELSE
        -- If they are already enrolled, send a message (optional)
        SELECT 'User is already enrolled in this course.' AS message;
    END IF;

END$$

DELIMITER ;

Call sp_EnrollUserInCourse(3,5);

# 3. Stored Procedure, This stored procedure helps fetch student enrollments for any student by ID, while filtering out non-students.  
DELIMITER //  
-- Create a procedure named GetStudentEnrollmentsByID  
-- It accepts one input parameter: studentId (an INT)  
CREATE PROCEDURE GetStudentEnrollmentsByID(IN studentId INT)  
BEGIN  
-- Select the student's enrolled courses ONLY if the user is a student (role_id = 3)  
SELECT u.user_id, 
u.name AS student_name,  
c.course_id,c.title AS course_title  
FROM enrollments e  
JOIN users u ON e.user_id = u.user_id 
JOIN courses c ON e.course_id = c.course_id 
WHERE u.user_id = studentId AND u.role_id = 3;  
END //  
DELIMITER ; 
CALL GetStudentEnrollmentsByID(5); 

-- ---------------------Trigger-----------------------------

DELIMITER $$
CREATE TRIGGER before_insert_users
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    -- ensure email is lowercase and trimmed
    IF NEW.email IS NOT NULL THEN
        SET NEW.email = LOWER(TRIM(NEW.email));
    END IF;

    -- trim name whitespace
    IF NEW.name IS NOT NULL THEN
        SET NEW.name = TRIM(NEW.name);
    END IF;

    -- If created_at was not explicitly provided, set to current timestamp (only if column allows overriding)
    IF NEW.created_at IS NULL THEN
        SET NEW.created_at = NOW();
    END IF;
END$$

DELIMITER ;

-- 2.Trigger : issueCertificateAfterCourseCompletion - Automatically insert a certificate when a student completes all quizzes in a course.
 
DELIMITER $$
 
CREATE TRIGGER before_certificate_insert_check_completion
BEFORE INSERT ON certificates
FOR EACH ROW
BEGIN
    DECLARE total_quizzes INT DEFAULT 0;
    DECLARE completed_quizzes INT DEFAULT 0;
 
    -- Count total quizzes under this course
    SELECT COUNT(q.quiz_id)
    INTO total_quizzes
    FROM quizzes q
    JOIN modules m ON q.module_id = m.module_id
    WHERE m.course_id = NEW.course_id;
 
    -- For simplicity, assume user must have taken (or completed) all quizzes
    -- In this version, we simulate completion by checking if quizzes exist.
    -- If no quizzes are found, skip restriction (open course).
    IF total_quizzes > 0 THEN
        -- Simulate that not all quizzes are done — for validation logic
        SET completed_quizzes = total_quizzes - 1; -- simulate incomplete state
 
        IF completed_quizzes < total_quizzes THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot issue certificate: user has not completed all quizzes for this course.';
        END IF;
    END IF;
END $$
 
DELIMITER ;

-- 3. Trigger to Inserts a new enrollment only if the user is a student (role_id = 3); otherwise, it blocks the action.  

DROP TRIGGER IF EXISTS before_enrollment_validate_student;  

DELIMITER $$  
CREATE TRIGGER before_enrollment_validate_student  
BEFORE INSERT ON enrollments  
FOR EACH ROW  
BEGIN  
DECLARE user_role INT;  
DECLARE enrollment_exists INT; 
-- Look up the role of the user trying to enroll 
SELECT role_id INTO user_role 
FROM users 
WHERE user_id = NEW.user_id;  
-- Block enrollment if user is not a student 
IF user_role != 3 THEN 
   SIGNAL SQLSTATE '45000' 
   SET MESSAGE_TEXT = 'Only users with role_id = 3 (Students) can be enrolled in courses'; 
END IF; 
 -- Check if enrollment already exists 
SELECT COUNT(*) INTO enrollment_exists 
FROM enrollments 
WHERE user_id = NEW.user_id AND course_id = NEW.course_id; 
 
IF enrollment_exists > 0 THEN 
   SIGNAL SQLSTATE '45000' 
   SET MESSAGE_TEXT = 'This student is already enrolled in this course'; 
END IF; 
END$$ DELIMITER ; 

-- Inserts only if user 2 is a student and not already enrolled in course 15; otherwise, it triggers an error. 
INSERT INTO enrollments (user_id, course_id) VALUES (2, 15);  
-- Inserts only if user 3 is a student and not already enrolled in course 13; otherwise, it triggers an error. 
INSERT INTO enrollments (user_id, course_id) VALUES (5, 13); 


-- --------------------------Function---------------------------------------

-- 1.Function : Check course completion - Check if a student has completed all quizzes in a course.
DELIMITER //

CREATE FUNCTION checkCourseCompletion(studentId INT, courseId INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_quizzes INT;
    DECLARE completed_quizzes INT;
    
    -- Count total quizzes in the course
    SELECT COUNT(q.quiz_id) INTO total_quizzes
    FROM quizzes q
    JOIN modules m ON q.module_id = m.module_id
    WHERE m.course_id = courseId;

    -- Count quizzes the student has passed (assuming you have a table 'quiz_attempts')
    SELECT COUNT(qa.quiz_id) INTO completed_quizzes
    FROM quiz_attempts qa
    JOIN quizzes q ON qa.quiz_id = q.quiz_id
    JOIN modules m ON q.module_id = m.module_id
    WHERE qa.user_id = studentId
      AND m.course_id = courseId
      AND qa.status = 'passed';
      
    -- If student completed all quizzes, return 1, else 0
    IF completed_quizzes = total_quizzes THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END //

DELIMITER ;
 
 -- 2.Function To get the average rating for any given course
DELIMITER $$

CREATE FUNCTION fn_GetCourseAverageRating(
    p_course_id INT
)
RETURNS DECIMAL(3, 2)
READS SQL DATA
BEGIN
    DECLARE avg_rating DECIMAL(3, 2);

    -- Calculate the average rating from the feedback table
    SELECT AVG(rating)
    INTO avg_rating
    FROM feedback
    WHERE course_id = p_course_id;

    -- If the course has no ratings, AVG() returns NULL. 
    -- COALESCE turns NULL into 0.00.
    RETURN COALESCE(avg_rating, 0.00);

END$$

DELIMITER ;

-- 3.function 

#Shows how many courses a student is enrolled in.  

DELIMITER //  

CREATE FUNCTION GetEnrollmentStatus(studentId INT)  
RETURNS VARCHAR(100)  
DETERMINISTIC  
BEGIN  
DECLARE total INT;  
DECLARE result VARCHAR(100); 

-- Count the number of courses the student is enrolled in 
SELECT COUNT(*) INTO total 
FROM enrollments e 
JOIN users u ON e.user_id = u.user_id 
WHERE u.role_id = 3 AND u.user_id = studentId; 
-- Use IF-ELSE logic to set the result 
IF total = 0 THEN 
   SET result = 'No enrollments'; 
ELSEIF total = 1 THEN 
   SET result = 'Enrolled in 1 course'; 
ELSE 
   SET result = CONCAT('Enrolled in ', total, ' courses'); 
END IF; 
 -- Return the message 
RETURN result; 
END // 
DELIMITER ;  
SELECT GetEnrollmentStatus(3); 
 