--Rising Temperature

--+---------------+---------+
--| Column Name   | Type    |
--+---------------+---------+
--| id            | int     |
--| recordDate    | date    |
--| temperature   | int     |
--+---------------+---------+
--id is the primary key for this table.
--This table contains information about the temperature on a certain DAY.

--SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

SELECT
	w1.id
FROM
	weather w1,
	weather w2
WHERE
	DATEDIFF(w1.recordDate,
	w2.recordDate) = 1
	AND w1.temperature > w2.temperature;
