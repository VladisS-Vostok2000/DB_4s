-- Задание 1
/*Вывести все имена и фамилии студентов, и название хобби,
которым занимается этот студент.*/
SELECT s.name, s.surname, h.name
FROM student s, student_hobby sh, hobby h
WHERE h.id = sh.hobby_id AND s.id = sh.student_id

-- Задание 2
/*Вывести информацию о студенте, занимающимся хобби
самое продолжительное время.*/
SELECT *
FROM student s, student_hobby sh
WHERE
s.id = sh.student_id AND
sh.date_finish - sh.date_start = (
	-- Самое длинное хобби
	SELECT MAX(sh.date_finish - sh.date_start)
	FROM student_hobby sh
)
 
-- Задание 3
/*Вывести имя, фамилию, номер зачетки и дату рождения
для студентов, средний балл которых выше среднего среди всех, 
а сумма риска всех хобби, которыми он занимается
в данный момент, больше 0.9.*/
SELECT s.id, s.name, s.surname, s.date_birth,
SUM(
	h.risk
)
FROM student s
INNER JOIN student_hobby sh on sh.student_id = s.id
INNER JOIN hobby h on h.id = sh.hobby_id
WHERE
	s.score > (
		-- Средний балл студентов
		SELECT AVG(s.score)
		FROM student s
	)
GROUP BY s.id, s.name, s.surname, s.date_birth
HAVING SUM(h.risk) > 0.9

-- Задание 4
/*Вывести фамилию, имя, зачетку, дату рождения,
название хобби и длительность в месяцах
для всех завершенных хобби. */

SELECT s.id, s.surname, s.name, s.date_birth,
	h.name,
	extract (month from age(date_finish, date_start)) as Длительность_в_месяцах
FROM student s
INNER JOIN student_hobby sh on s.id = sh.student_id
INNER JOIN hobby h on sh.hobby_id = h.id
WHERE sh.date_finish IS NOT NULL

-- Задание 5
/* Вывести фамилию, имя, зачетку, дату рождения студентов,
которым исполнилось N полных лет на текущую дату,
и которые имеют более 1 действующего хобби. */
SELECT s.surname, s.name, s.id, s.date_birth
FROM student s
INNER JOIN student_hobby sh ON s.id = sh.id
WHERE extract(year from age(CURRENT_DATE, s.date_birth)) = 22
	AND (
		SELECT COUNT(*)
		FROM student_hobby sh
		WHERE date_finish IS NOT NULL AND
			sh.student_id = s.id
	) > -1
	
	
-- Задание 6
/* Найти средний балл в каждой группе, учитывая только
баллы студентов, которые имеют хотя бы одно действующее
хобби. */
SELECT AVG(s.score)
FROM student s
INNER JOIN student_hobby sh ON sh.student_id = s.id
WHERE sh.date_finish IS NULL
GROUP BY s.n_group

-- Задание 7
/* Найти название, риск, длительность в месяцах самого
продолжительного хобби из действующих, указав номер
зачетки студента. */
SELECT s.id, h.name, h.risk,
	CURRENT_DATE - sh.date_start as Длительность_хобби
FROM student s
INNER JOIN student_hobby sh ON sh.student_id = s.id
INNER JOIN hobby h ON sh.hobby_id = h.id
ORDER BY CURRENT_DATE - sh.date_start DESC
LIMIT 1

-- Задание 8
/* Найти все хобби, которыми увлекаются студенты, имеющие
максимальный балл. */
SELECT h.name
FROM hobby h
INNER JOIN student_hobby sh ON sh.hobby_id = h.id
INNER JOIN student s ON s.id = sh.student_id
WHERE
	(
		SELECT MAX(s.score)
		FROM student s
	) = s.score

-- Задание 9
/* Найти все действующие хобби, которыми увлекаются
троечники 2-го курса. */
SELECT *
FROM hobby h
INNER JOIN student_hobby sh ON sh.hobby_id = h.id
INNER JOIN student s ON s.id = sh.student_id
WHERE
	substring(s.n_group::varchar from 1 for 1)::INTEGER = 2 AND
	s.score BETWEEN 3 AND 3.999
	
-- Задание 10
/* Найти номера курсов, на которых более 50% студентов имеют
более одного действующего хобби. */

-- Задание 11
/* Вывести номера групп, в которых не менее 60% студентов имеют балл не ниже 4. */

-- Задание 12
/* Для каждого курса подсчитать количество различных
действующих хобби на курсе. */
SELECT
	substring(s.n_group::varchar from 1 for 1)::INTEGER as Курс,
	COUNT(DISTINCT h.name) as Различных_действующие_хобби
FROM student s
INNER JOIN student_hobby sh ON sh.hobby_id = s.id
INNER JOIN hobby h ON sh.hobby_id = h.id
WHERE sh.date_finish IS NULL
GROUP BY substring(s.n_group::varchar from 1 for 1)








-- Задание 27
SELECT substr(name, 1, 1), max(score), avg(score)::real, min(score)
FROM table
GROUP BY substr(name, 1, 1)