-- Create Database for Assignment question 1
CREATE DATABASE antivirus_detection

-- Create Table : File Types
CREATE TABLE file_types(
id int NOT NULL,
extension varchar(255) NOT NULL,
PRIMARY KEY(id),
UNIQUE(extension)
);

-- Create Table : quantumsafe_detections
CREATE TABLE quantumsafe_detections(
filetype_id int NOT NULL,
dt varchar(19) NOT NULL,
FOREIGN KEY(filetype_id) REFERENCES file_types(id)
);

-- Create Table : webguardian_detections
CREATE TABLE webguardian_detections(
filetype_id int NOT NULL,
dt varchar(19) NOT NULL,
FOREIGN KEY(filetype_id) REFERENCES file_types(id)
);

-- Insert values in table : File Types
INSERT INTO file_types(id, extension)
VALUES (1,'*.txt'),
(2,'*.doc'),
(3,'*.pdf');

-- Insert values in table : quantumsafe_detections
INSERT INTO quantumsafe_detections(filetype_id, dt)
VALUES (1,'2023-06-26 01:17:50'),
		(1,'2023-06-27 02:17:16'),
		(3,'2023-06-29 02:20:45'),
		(1,'2023-07-14 23:55:15'),
		(1,'2023-07-19 15:42:24'),
		(1,'2023-07-21 23:09:52'),
		(1,'2023-07-13 22:02:16'),
		(1,'2023-07-24 20:48:17'),
		(2,'2023-07-12 23:24:37'),
		(2,'2023-07-30 06:51:58'),
		(2,'2023-07-20 05:44:05'),
		(3,'2023-07-27 20:33:29'),
		(3,'2023-07-04 07:02:14'),
		(3,'2023-07-11 23:41:55'),
		(1,'2023-08-04 04:45:24'),
		(1,'2023-08-01 22:43:07'),
		(1,'2023-08-01 22:43:07'),
		(2,'2023-08-02 23:47:40'),
		(3,'2023-08-04 09:24:51'),
		(3,'2023-08-04 01:12:32');

-- Insert values in table : webguardian_detections
INSERT INTO webguardian_detections(filetype_id,dt)
VALUES (2,'2023-06-27 05:47:41'),
		(3,'2023-06-27 21:33:48'),
		(1,'2023-07-08 15:20:00'),
		(1,'2023-07-12 12:34:59'),
		(1,'2023-07-08 15:11:47'),
		(1,'2023-07-24 16:34:24'),
		(1,'2023-07-23 17:45:16'),
		(2,'2023-07-09 11:35:14'),
		(2,'2023-07-29 13:12:22'),
		(2,'2023-07-29 22:50:15'),
		(3,'2023-07-16 16:44:23'),
		(3,'2023-07-09 07:09:54'),
		(3,'2023-07-21 13:40:45'),
		(3,'2023-07-14 09:26:13'),
		(3,'2023-07-02 04:25:56'),
		(3,'2023-07-29 10:22:25'),
		(2,'2023-08-03 03:23:29'),
		(2,'2023-08-02 15:35:55'),
		(2,'2023-08-03 15:29:04'),
		(3,'2023-08-03 09:16:56');
		
		
-- Output query
SELECT extension, 
	   SUM(quantumsafe_total_detections) AS quantumsafe_total_detections,
       SUM(web_total_detections) AS web_total_detections
FROM (
    SELECT file_types.extension AS extension, COUNT(*) AS web_total_detections, 0 AS quantumsafe_total_detections
    FROM webguardian_detections
    INNER JOIN file_types ON file_types.id = filetype_id
    WHERE dt LIKE '2023-07%'
    GROUP BY filetype_id

    UNION ALL

    SELECT file_types.extension AS extension, 0 AS web_total_detections, COUNT(*) AS quantumsafe_total_detections
    FROM quantumsafe_detections
    INNER JOIN file_types ON file_types.id = filetype_id
    WHERE dt LIKE '2023-07%'
    GROUP BY filetype_id
) AS combined_detections
GROUP BY extension
ORDER BY extension;

