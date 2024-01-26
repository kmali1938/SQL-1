    
    
-- Create Database for Assignment question 2 : Employee History Query
CREATE DATABASE employye_history

-- Create Table People
CREATE TABLE People(
id varchar(255),
name VARCHAR(255),
doj DATE,
prev_company_id VARCHAR(255),
curr_company_id VARCHAR(255));

-- Create table Companies
CREATE TABLE Companies(
id varchar(255),
name varchar(255));

-- Insert data in table People
INSERT INTO People(id,name,doj,prev_company_id,curr_company_id)
VALUES ('1795f7b21f7747ec80247edbd1c4a73b','Alex Brown','1973-03-02','4e5b9def5e524e71945edbdd5faca821','49de6e9a72fc48feb3559358ec00fdb9'),
('877246723d6f4d5a9e5714d514a531a9','Chris Mitchell','2016-06-15','4746565c0d684b339391636bb8c76368','4e5b9def5e524e71945edbdd5faca821'),
('5e031fa585664babbea695f5d11da9ed','Pat Hobbs','1976-09-14','4e5b9def5e524e71945edbdd5faca821','4746565c0d684b339391636bb8c76368');

-- Display table People
-- SELECT * FROM People;

-- Insert data in table Company
INSERT INTO Companies(id,name)
VALUES ('4746565c0d684b339391636bb8c76368','Mora-Sullivan'),
('49de6e9a72fc48feb3559358ec00fdb9','Harmon-Miller'),
('4e5b9def5e524e71945edbdd5faca821','Fakesmith');

-- Display table Companies
-- SELECT * FROM Companies;

-- Output query
SELECT People.name AS EmployeeName, Companies.name AS CompanyName
FROM People
INNER JOIN Companies ON People.prev_company_id= Companies.id
WHERE People.prev_company_id = (
	SELECT prev_company_id 
	FROM People
	Where curr_company_id = (
		SELECT prev_company_id
    		FROM People
    		GROUP BY prev_company_id
    		ORDER BY COUNT(prev_company_id) DESC
    		LIMIT 1

)
);

