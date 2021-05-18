-- Задание 1
SELECT s.n_group,
	COUNT(n_group)
FROM student s
GROUP BY n_group

-- Задание 2
SELECT s.n_group,
MAX (s.score)
FROM student s
GROUP BY s.n_group

-- Задание 3
SELECT
COUNT (DISTINCT s.surname)
FROM student s

-- Задание 4
-- Подсчитать студентов, которые родились в каждом году
SELECT
	-- Год рождения
	to_char(s.date_birth, 'YYYY'),
	COUNT (*)
FROM student s
GROUP BY (to_char(s.date_birth, 'YYYY'))

-- Задание 5
SELECT substring(s.n_group::varchar from 1 for 1),
AVG (s.score)::REAL
FROM student s
GROUP BY substring(s.n_group::varchar from 1 for 1)

-- Задание 6
SELECT s.n_group,
MAX(s.score)
FROM student s
GROUP BY s.n_group
ORDER BY MAX(s.score)
LIMIT 1

-- Задание 7
/*Для каждой группы подсчитать средний балл,
вывести на экран только те номера групп и
их средний балл, в которых он менее или равен 3.5.
Отсортировать по от меньшего среднего балла к большему.*/
SELECT
	s.n_group,
	AVG(s.score)
FROM student s
GROUP BY s.n_group
HAVING AVG(s.score) > 3.5
ORDER BY AVG(s.score)

-- Задание 8
/*
Для каждой группы в одном запросе вывести
количество студентов, максимальный балл в группе,
средний балл в группе, минимальный балл в группе.
*/
SELECT
	s.n_group,
	COUNT(*),
	MAX(s.score),
	AVG(s.score),
	MIN(s.score)
FROM student s
GROUP BY s.n_group

-- Задание 9 (не доделано)
/* Вывести студента/ов, который/ые имеют наибольший балл
в заданной группе */
SELECT
	AVG(s.n_group)
FROM student s
WHERE score = (
	SELECT MAX(score) FROM student
)
GROUP BY s.n_group

-- Задание 9
/* Вывести студентов, которые имеют наибольший балл
в заданной группе */
SELECT s.name
FROM student s
WHERE (
	s.n_group = 2254 AND
	s.score = (
		SELECT MAX(score)
		FROM student s
		GROUP BY s.n_group
		HAVING s.n_group = 2254
	)
)

-- Задание 10
/* вывести в одном запросе для каждой группы
студента с максимальным баллом */
SELECT s.name
FROM student s
WHERE (
	s.score = (
		SELECT MAX(score)
		FROM student ss
		GROUP BY s.n_group
		HAVING ss.n_group = s.n_group
	)
)

SELECT s.name
FROM student s
WHERE 
	(s.n_group, s.score) IN (
		SELECT s.n_group, MAX(score)
		FROM student s
		GROUP BY s.n_group
	)
	
	
SELECT s.name
FROM student s
INNER JOIN (
		SELECT s.n_group, MAX(score) as m_s
		FROM student s
		GROUP BY s.n_group
	) t ON s.n_group = t.n_group AND s.score = t.m_s