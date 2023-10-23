CREATE DATABASE company;
GO

CREATE TABLE departaments(
	id INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(255)
);

CREATE TABLE employees(
	employee_id INT IDENTITY(1,1) PRIMARY KEY,
	first_name VARCHAR(40) NOT NULL,
	last_name VARCHAR(40) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	department_id INT FOREIGN KEY REFERENCES departaments(id)
);
GO

INSERT INTO departaments(name)
VALUES ('TI'), ('Suporte'), ('Vendas'), ('RH');

INSERT INTO employees(first_name, last_name, email, department_id)
VALUES ('João', 'Silva', 'joao.silva@example.com', 1),
       ('Maria', 'Santos', 'maria.santos@example.com', 2),
       ('Pedro', 'Ribeiro', 'pedro.ribeiro@example.com', 3),
	   ('Felipe', 'Ribeiro', 'Felipe.@gmail.com', 4),
	   ('Ariane','Lacerda','Ariane@gmail.com',4);

SELECT * FROM employees;

SELECT first_name, last_name FROM employees WHERE department_id = 3;

UPDATE employees
SET email = 'novonome@email.com'
WHERE employee_id = 8

UPDATE employees
SET department_id = 2
WHERE department_id = 4

DELETE FROM departaments WHERE name = 'RH';

INSERT INTO employees (first_name, last_name, email, department_id)
VALUES ('Adriano', 'ASILO', 'Asilssva@gmail.com', 2)

SELECT first_name, last_name 
From employees
WHERE first_name LIKE 'A%' AND last_name LIKE 'A%'
