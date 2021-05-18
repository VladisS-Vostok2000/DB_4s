-- Задание 1:
SELECT st.name, st.surname
FROM student st
WHERE st.score >= 4 AND st.score <= 4.5

-- Задание 2:
SELECT *
FROM student st
WHERE st.n_group / 1000 = 2
-- Зачем оператор CAST...?

-- Второй вариант
SELECT *
FROM student st
WHERE st.n_group::varchar like '2%'

-- Задание 3:
SELECT *
FROM student st
ORDER BY
	st.n_group DESC,
	st.name DESC

-- Задание 4:
SELECT *
FROM student st
WHERE st.score >= 4
ORDER BY
	st.score DESC

-- Задание 5:
SELECT name, risk
FROM hobby h
WHERE h.name = 'футбол' OR h.name = 'хоккей'

-- Задание 6:
SELECT sh.hobby_id, sh.student_id
FROM student_hobby sh
WHERE sh.date_start BETWEEN '01.01.2000' AND '01.01.2010'
	AND date_finish IS NULL
-- Исключение IS NULL неочевидно

-- Задание 7:
SELECT *
FROM student s
WHERE s.score >= 4.5
ORDER BY s.score DESC

-- Задание 8:
SELECT *
FROM student s
WHERE s.score >= 4.5
ORDER BY s.score DESC
LIMIT 5

-- Задание 9
SELECT h.name,
       CASE
           WHEN h.risk >= 8 THEN 'Очень высокий'
           WHEN h.risk >= 6 AND h.risk < 8 THEN 'Высокий'
		   WHEN h.risk >= 4 AND h.risk < 6 THEN 'Средний'
		   WHEN h.risk >= 2 AND h.risk < 4 THEN 'Низкий'
		   ELSE 'Очень низкий'
       END AS Риск
FROM hobby h

-- Задание 10:
SELECT *
FROM hobby h
ORDER BY h.risk DESC
LIMIT 3


























