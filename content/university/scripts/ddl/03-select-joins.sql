-- Listar los programas relacionados a la facultad de salud.

-- associated tables: university.faculties T1 ; university.programs T2
-- keys: T1.faculty_id = T2.faculty_id

SELECT
    T2.name AS program,
    T1.name AS faculty
FROM university.faculties T1
INNER JOIN university.programs T2
    ON T1.faculty_id = T2.faculty_id
WHERE T1.name LIKE '%Facultad de Salud%'
ORDER BY T2.name;


-- Obtener el nombre completo del estudiante, el nombre del curso
-- y el nombre del salón en el que está inscrito.
-- Solo mostrar estudiantes que estén inscritos en al menos una oferta.
-- Ordenar por apellido del estudiante.
-- Tipo de JOIN: INNER

--SELECT
    CONCAT(T1.first_name, ' ', T1.last_name) AS estudiante,
    T4.name AS curso,
    T6.name AS salon
FROM university.users T1
INNER JOIN university.enrollments T2
    ON T1.user_id = T2.student_id
INNER JOIN university.course_offerings T3
    ON T2.course_offering_id = T3.course_offering_id
INNER JOIN university.courses T4
    ON T3.course_id = T4.course_id
INNER JOIN university.classrooms T6
    ON T3.classroom_id = T6.classroom_id
ORDER BY T1.last_name;

-- Obtener todos los cursos junto con el nombre de la facultad
-- que los ofrece y el programa académico al que pertenecen.
-- Incluir cursos aunque no estén asignados a ningún programa.
-- Ordenar por nombre de la facultad.
-- Tipo de JOIN: LEFT

SELECT
    T1.name AS curso,
    T4.name AS programa,
    T5.name AS facultad
FROM university.courses T1
LEFT JOIN university.programs_courses T2
    ON T1.course_id = T2.course_id
LEFT JOIN university.programs T4
    ON T2.program_id = T4.program_id
LEFT JOIN university.faculties T5
    ON T4.faculty_id = T5.faculty_id
ORDER BY T5.name;
--

-- Obtener el nombre completo del profesor, el nombre del curso
-- que dicta, el día de la semana y el horario de inicio y fin.
-- Solo mostrar ofertas que tengan profesor y horario asignado.
-- Ordenar por día de la semana y hora de inicio.
-- Tipo de JOIN: INNER
--
SELECT
    CONCAT(T1.first_name, ' ', T1.last_name) AS profesor,
    T3.name AS curso,
    T4.day AS dia,
    T4.start_time AS hora_inicio,
    T4.end_time AS hora_fin
FROM university.users T1
INNER JOIN university.course_offerings T2
    ON T1.user_id = T2.professor_id
INNER JOIN university.courses T3
    ON T2.course_id = T3.course_id
INNER JOIN university.schedules T4
    ON T2.schedule_id = T4.schedule_id
ORDER BY T4.day, T4.start_time;

-- Obtener el nombre del edificio, el nombre del salón
-- y el nombre del curso que se dicta en cada salón.
-- Incluir todos los salones aunque no tengan ninguna
-- oferta de curso asignada.
-- Ordenar por nombre del edificio y luego por salón.
-- Tipo de JOIN: LEFT

SELECT
    T1.name AS edificio,
    T2.name AS salon,
    T4.name AS curso
FROM university.buildings T1
LEFT JOIN university.classrooms T2
    ON T1.building_id = T2.building_id
LEFT JOIN university.course_offerings T3
    ON T2.classroom_id = T3.classroom_id
LEFT JOIN university.courses T4
    ON T3.course_id = T4.course_id
ORDER BY T1.name, T2.name;

-- tables related: university.faculties; university.programs
SELECT
    T1.name AS Facultades,
    T2.name AS Programas
FROM university.faculties T1
INNER JOIN university.programs T2
    ON T1.faculty_id = T2.faculty_id
WHERE T1.name = 'Facultad de Ciencias Económicas y Empresariales';


-- Encontrar el salon y el edificio, en el cual se ofrece el curso
-- de Cálculo Diferencial

-- tables related:
university.courses T1
university.course_offerings T2 | T1.course_id = T2.course_id
university.classrooms T3       | T2.classroom_id = T3.classroom_id
university.buildings T4        | T3.building_id = T4.building_id

SELECT
    T4.name AS Edificio,
    T3.name AS Salon
FROM university.courses T1
INNER JOIN university.course_offerings T2 
    ON T1.course_id = T2.course_id
INNER JOIN university.classrooms T3       
    ON T2.classroom_id = T3.classroom_id
INNER JOIN university.buildings T4        
    ON T3.building_id = T4.building_id
WHERE T1.name LIKE '%Cálculo Diferencial%';


-- Identificar que personas tiene o no el rol de Admin
SELECT
    *
FROM university.roles T1
RIGHT JOIN university.users T2
    ON T1.role_id = T2.role_id
WHERE T1.name = 'Admin';

SELECT
    *
FROM university.roles T1
RIGHT JOIN university.users T2
    ON T1.role_id = T2.role_id
WHERE T1.name = 'Admin';