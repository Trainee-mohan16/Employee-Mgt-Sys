-- Create the database
CREATE DATABASE IF NOT EXISTS employee_management;
USE employee_management;

-- Create Departments table
CREATE TABLE IF NOT EXISTS Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

-- Create Employees table
CREATE TABLE IF NOT EXISTS Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Create Projects table
CREATE TABLE IF NOT EXISTS Projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    start_date DATE,
    end_date DATE
);

-- Create Assignments table
CREATE TABLE IF NOT EXISTS Assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

-- Insert data into Departments table
INSERT INTO Departments (department_name)
VALUES 
    ('Human Resources'),
    ('Engineering'),
    ('Marketing'),
    ('Sales');

-- Insert data into Employees table
INSERT INTO Employees (first_name, last_name, email, phone_number, hire_date, department_id)
VALUES 
    ('John', 'Doe', 'john.doe@example.com', '555-1234', '2020-01-15', 2),
    ('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '2019-03-22', 1),
    ('Alice', 'Johnson', 'alice.johnson@example.com', '555-9101', '2021-07-30', 3),
    ('Bob', 'Brown', 'bob.brown@example.com', '555-1122', '2018-05-12', 4),
    ('Charlie', 'Davis', 'charlie.davis@example.com', '555-1314', '2022-10-05', 2);

-- Insert data into Projects table
INSERT INTO Projects (project_name, start_date, end_date)
VALUES 
    ('Project Alpha', '2024-01-01', '2024-06-30'),
    ('Project Beta', '2024-02-15', '2024-08-15'),
    ('Project Gamma', '2024-03-01', '2024-12-31'),
    ('Project Delta', '2024-04-20', '2024-11-30');

-- Insert data into Assignments table
INSERT INTO Assignments (employee_id, project_id, start_date, end_date)
VALUES 
    (1, 1, '2024-01-01', '2024-06-30'),
    (2, 2, '2024-02-15', '2024-08-15'),
    (3, 3, '2024-03-01', '2024-12-31'),
    (4, 4, '2024-04-20', '2024-11-30'),
    (1, 3, '2024-03-01', '2024-12-31');

SELECT e.first_name, e.last_name, d.department_name
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id;

SELECT p.project_name, e.first_name, e.last_name, a.start_date, a.end_date
FROM Assignments a
JOIN Projects p ON a.project_id = p.project_id
JOIN Employees e ON a.employee_id = e.employee_id;

SELECT e.first_name, e.last_name, COUNT(a.project_id) AS project_count
FROM Assignments a
JOIN Employees e ON a.employee_id = e.employee_id
GROUP BY e.employee_id
HAVING COUNT(a.project_id) > 1;

SELECT p.project_name
FROM Projects p
LEFT JOIN Assignments a ON p.project_id = a.project_id
WHERE a.project_id IS NULL;

SELECT e.first_name, e.last_name
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering';
