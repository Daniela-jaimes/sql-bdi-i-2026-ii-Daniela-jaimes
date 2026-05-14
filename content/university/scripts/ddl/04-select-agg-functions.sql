-- Obtener el total de programas por cada facultad
-- ordenado de la facultad con mas programas hacia abajo.
SELECT
    T1.name AS faculty,
    COUNT(*) AS total_programs

FROM university.faculties T1
INNER JOIN university.programs T2
    ON T1.faculty_id = T2.faculty_id
GROUP BY T1.name
ORDER BY total_programs DESC;

-- Obtener el total de estudiantes registrados en el sistema
-- que tengan el rol de estudiante.
-- Tipo de JOIN: INNER
-- Agregación: COUNT
SELECT COUNT(*) AS total_students
FROM university.users u
INNER JOIN university.roles r
    ON u.role_id = r.role_id
WHERE r.name = 'Estudiante';

-- Obtener la capacidad máxima entre todas las ofertas de curso
-- que se dictan en un edificio específico.
-- Tipo de JOIN: INNER
-- Agregación: MAX
SELECT 
    b.name AS building,
    MAX(co.capacity) AS max_capacity
FROM university.course_offerings co
INNER JOIN university.classrooms c
    ON co.classroom_id = c.classroom_id
INNER JOIN university.buildings b
    ON c.building_id = b.building_id
WHERE b.name = 'Bloque A - Ingenierias'
GROUP BY b.name;


-- Obtener la capacidad mínima registrada entre todas las ofertas
-- de curso disponibles, mostrando el nombre del curso asociado.
-- Tipo de JOIN: INNER
-- Agregación: MIN

SELECT 
    c.name AS course,
    MIN(co.capacity) AS min_capacity
FROM university.course_offerings co
INNER JOIN university.courses c
    ON co.course_id = c.course_id
GROUP BY c.name
ORDER BY min_capacity ASC
LIMIT 1;


-- Obtener la suma total de capacidad disponible en todas las
-- ofertas de curso que pertenecen a una facultad específica.
-- Tipo de JOIN: INNER
-- Agregación: SUM

SELECT 
    f.name AS faculty,
    SUM(co.capacity) AS total_capacity
FROM university.course_offerings co
INNER JOIN university.courses c
    ON co.course_id = c.course_id
INNER JOIN university.programs_courses pc
    ON c.course_id = pc.course_id
INNER JOIN university.programs p
    ON pc.program_id = p.program_id
INNER JOIN university.faculties f
    ON p.faculty_id = f.faculty_id
WHERE f.name = 'Facultad de Ingenierías y Arquitectura'
GROUP BY f.name;

-- Obtener el promedio de capacidad de todas las ofertas de curso
-- que se dictan los días lunes.
-- Tipo de JOIN: INNER
-- Agregación: AVG

SELECT 
    AVG(co.capacity) AS average_capacity
FROM university.course_offerings co
INNER JOIN university.schedules s
    ON co.schedule_id = s.schedule_id
WHERE s.day = 'Lunes';

-- Obtener cuántas ofertas de curso tiene asignadas en total
-- un profesor específico, mostrando su nombre completo.
-- Tipo de JOIN: INNER
-- Agregación: COUNT

SELECT 
    CONCAT(u.first_name, ' ', u.last_name) AS professor,
    COUNT(co.course_offering_id) AS total_offerings
FROM university.course_offerings co
INNER JOIN university.users u
    ON co.professor_id = u.user_id
WHERE u.user_id = 1
GROUP BY professor;

-- Obtener el número total de cursos que pertenecen al plan
-- de estudios de un programa académico específico,
-- incluyendo los semestres en los que aparecen.
-- Tipo de JOIN: INNER
-- Agregación: COUNT

SELECT 
    p.name AS program,
    pc.semester,
    COUNT(pc.course_id) AS total_courses
FROM university.programs_courses pc
INNER JOIN university.programs p
    ON pc.program_id = p.program_id
WHERE p.name = 'Ingeniería de Sistemas'
GROUP BY p.name, pc.semester
ORDER BY pc.semester;

-- Obtener la cantidad de estudiantes inscritos en una
-- oferta de curso específica, mostrando el nombre del curso
-- y el nombre completo del profesor que la dicta.
-- Tipo de JOIN: INNER
-- Agregación: COUNT

SELECT 
    c.name AS course,
    CONCAT(u.first_name, ' ', u.last_name) AS professor,
    COUNT(e.enrollment_id) AS total_students
FROM university.enrollments e
INNER JOIN university.course_offerings co
    ON e.course_offering_id = co.course_offering_id
INNER JOIN university.courses c
    ON co.course_id = c.course_id
INNER JOIN university.users u
    ON co.professor_id = u.user_id
WHERE co.course_offering_id = 1
GROUP BY c.name, professor;