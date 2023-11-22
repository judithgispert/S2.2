USE Universidad;

-- 1. Returns a list with (surname 1 + surname 2 + name) of all the students. The list must be ordered alphabetically from lowest to highest by surname 1, surname 2 and name.
SELECT apellido1 AS 'Surname 1', apellido2 AS 'Surname 2', nombre AS 'Student name' FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;

-- 2. Finds the first and last names of students who haven't registered their phone number in the database.
SELECT nombre AS 'Name', apellido1 AS 'Surname 1', apellido2 AS 'Surname 2' FROM persona WHERE telefono IS NULL;

-- 3. Returns the list of students who were born in 1999.
SELECT * FROM persona WHERE YEAR(fecha_nacimiento) = 1999 AND tipo = 'alumno';

-- 4. Returns the list of teachers who haven't registered their phone number in the database and algo their nif ends in K.
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- 5. Returns the list of subjects that are in the first semester, in the third year of the degree that has the id = 7.
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- 6. Returns a list of teachers + their departament name. Show four columns (surname 1, surname 2, name and department name). The result will be sorted alphabetically from lowest to highest by surname and name.
SELECT p.apellido1 AS 'Surname 1', p.apellido2 AS 'Surname 2', p.nombre AS 'Teacher name', pr.id_departamento AS 'Department name' FROM persona p INNER JOIN departamento d INNER JOIN profesor pr ON d.id = pr.id_departamento AND p.id = pr.id_profesor ORDER BY p.apellido1 DESC, p.apellido2 DESC, p.nombre DESC;

-- 7. Returns a list of (the names of the subjects + start university year + end university year) of the student's with NIF 26902806M.
SELECT a.nombre AS 'Subject name', c.anyo_inicio AS 'Year (start)', c.anyo_fin AS 'Year (End)' FROM curso_escolar c INNER JOIN alumno_se_matricula_asignatura am INNER JOIN persona p INNER JOIN asignatura a ON am.id_alumno = p.id AND am.id_curso_escolar = c.id AND am.id_asignatura = a.id WHERE p.nif = '26902806M';

-- 8. Returns a list of the names of all the departments that have teachers who teach a subject in the "Grau en Enginyeria Informàtica (Pla 2015)".
SELECT DISTINCT d.nombre AS 'Department name' FROM departamento d INNER JOIN profesor p INNER JOIN asignatura a INNER JOIN grado g ON d.id = p.id_departamento AND a.id_profesor = p.id_profesor AND a.id_grado = g.id WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9. Returns a list of all students who have enrolled in a subject during the 2018/2019 university year.
SELECT DISTINCT p.* FROM persona p INNER JOIN curso_escolar c INNER JOIN alumno_se_matricula_asignatura am ON p.id = am.id_alumno AND c.id = am.id_curso_escolar WHERE c.anyo_inicio = 2018 AND c.anyo_fin = 2019;

/* QUERIES WITH LEFT JOIN AND RIGHT JOIN */
-- 1. Returns a list of the names of all the professors and departments they are linked to. The list must also show those teachers who don't have any associate department. The list must return four columns, name of the department, surname 1, surname 2 and name of the teacher. The result will be ordered alphabetically from lowest to highest by department name, surnames and name.
SELECT d.nombre AS 'Department name', p.apellido1 AS 'Surname 1', p.apellido2 AS 'Surname 2', p.nombre AS 'Name' FROM persona p JOIN departamento d RIGHT OUTER JOIN profesor pr ON p.id = pr.id_profesor AND d.id = pr.id_departamento ORDER BY d.nombre DESC, p.apellido1 DESC, p.apellido2 DESC, p.nombre DESC;

-- 2. Returns a list of professors who aren't associated with a department.
SELECT p.* FROM persona p LEFT OUTER JOIN profesor pr ON p.id = pr.id_profesor WHERE tipo = 'profesor' AND pr.id_departamento IS NULL;

-- 3. Returns a list of departments that don't have associate professors.
SELECT d.* FROM departamento d LEFT OUTER JOIN profesor pr ON d.id = pr.id_departamento WHERE id_departamento IS NULL;

-- 4. Returns a list of teachers who don't teach any subjects.
SELECT p.* FROM persona p LEFT OUTER JOIN profesor pr ON p.id = pr.id_profesor LEFT OUTER JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' AND a.nombre IS NULL;  

-- 5. Returns a list of subjects that don't have an assigned teacher.
SELECT a.* FROM asignatura a LEFT OUTER JOIN profesor pr ON a.id_profesor = pr.id_profesor WHERE a.id_profesor IS NULL; 

-- 6. Returns a list of all departments that haven't taught subjects in any university year.
SELECT DISTINCT d.* FROM departamento d LEFT OUTER JOIN profesor pr ON d.id = pr.id_departamento LEFT OUTER JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE pr.id_departamento IS NULL; 

/* SUMMARY QUERIES*/
-- 1. Returns the total number of students there.
SELECT COUNT(*) AS 'Total num of students' FROM persona WHERE tipo = 'alumno';

-- 2. Calculate how many students were born in 1999.
SELECT COUNT(*) AS 'Students who were born in 1999' FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 3. Calculate how many teachers there are in each department. The result should only show two columns, one with the name of the department and another with the number of teachers in that department. The result must only include the departments that have associate professors and must be ordered from highest to lowest by the number of professors.
SELECT d.nombre AS 'Department name', COUNT(pr.id_profesor) AS 'Number of teachers' FROM departamento d INNER JOIN profesor pr ON d.id = pr.id_departamento GROUP BY d.nombre ORDER BY COUNT(pr.id_profesor) DESC;

-- 4. Returns a list with all the departments and the number of professors in each of them. Keep in mind that there may be departments that don't have associate professors. These departments must also appear in the list.
SELECT d.nombre AS 'Department name', COUNT(pr.id_profesor) AS 'Number of teachers' FROM departamento d LEFT OUTER JOIN profesor pr ON d.id = pr.id_departamento GROUP BY d.nombre;

-- 5. Returns a list with the name of all the existing degrees in the database and the number of subjects each one has. There may be degrees that don't have associated subjects. These grades must also appear in the listing. The result must be ordered from highest to lowest by the number of subjects.
SELECT DISTINCT g.nombre AS 'Grade name', COUNT(a.nombre) AS "Number of subjects" FROM grado g LEFT OUTER JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY COUNT(a.nombre) DESC;

-- 6. Returns a list with the name of all the existing degrees in the database and the number of subjects each has, of the degrees that have more than 40 associated subjects.
SELECT DISTINCT g.nombre AS 'Grade name', COUNT(a.nombre) AS "Number of subjects" FROM grado g INNER JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre HAVING COUNT(a.nombre) > 40;

-- 7. Returns a list showing the name of degrees and the total number of credits for each subject type. The result must have three columns: name of the degree, type of subject and the sum of the credits of all subjects of that type.
SELECT g.nombre AS 'Grade name', a.tipo AS "Subject type", SUM(a.creditos) AS 'Number of credits' FROM grado g INNER JOIN asignatura a ON g.id = a.id_grado GROUP BY a.tipo, g.nombre; 

-- 8. Returns a list that shows how many students have enrolled in a subject in each of the school years. The result must show two columns, one column with the start year of the school year and another with the number of enrolled students.
SELECT c.anyo_inicio AS "Course start year", COUNT(am.id_alumno) AS "Number of enrolled students" FROM curso_escolar c LEFT OUTER JOIN alumno_se_matricula_asignatura am ON am.id_curso_escolar = c.id GROUP BY c.anyo_inicio; 

-- 9. Returns a list with the number of subjects taught by each teacher. The list must take into account those professors who do not teach any subjects. The result will show five columns: id, name, first last name, second last name and number of subjects. The result will be ordered from highest to lowest by the number of subjects.
SELECT p.id AS 'ID teacher', p.nombre AS 'Name', p.apellido1 AS 'Surname 1', p.apellido2 AS 'Surname 2', COUNT(a.nombre) AS "Number of subjects" FROM persona p LEFT OUTER JOIN profesor pr ON p.id = pr.id_profesor LEFT OUTER JOIN asignatura a ON a.id_profesor = pr.id_profesor WHERE p.tipo = 'profesor' GROUP BY p.id ORDER BY COUNT(a.nombre) DESC; 

-- 10. Returns all data for the youngest student.
SELECT * FROM persona p WHERE p.tipo = 'alumno' AND p.fecha_nacimiento = (SELECT MAX(p.fecha_nacimiento) FROM persona p);

-- 11. Returns a list of professors who have an associated department and who don't teach any subjects.
SELECT pr.* FROM profesor pr LEFT OUTER JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE pr.id_departamento IS NOT NULL AND a.id_profesor IS NULL;