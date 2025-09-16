-- =============================================================
-- QUERIES ANALÍTICAS - Sistema de Gestión de Proyectos
-- Autores: Carolina Velasquez Avila, Johnatan Velez, Gabriel Eduardo Villarreal
-- Fecha: 2025-09-15
-- =============================================================

-- Query 1: Docentes con más de 10 años de experiencia
SELECT docente_id, nombres, anios_experiencia, tipo_docente
FROM docente
WHERE anios_experiencia > 10
ORDER BY anios_experiencia DESC;

-- Query 2: Proyectos con presupuesto mayor a 10 millones
SELECT proyecto_id, nombre, presupuesto, fecha_inicial, fecha_final
FROM proyecto
WHERE presupuesto > 10000000
ORDER BY presupuesto DESC;

-- Query 3: Total de proyectos por docente jefe
SELECT d.nombres AS docente_jefe, COUNT(p.proyecto_id) AS total_proyectos
FROM docente d
LEFT JOIN proyecto p ON d.docente_id = p.docente_id_jefe
GROUP BY d.docente_id, d.nombres
ORDER BY total_proyectos DESC;

-- Query 4: Presupuesto total de todos los proyectos
SELECT SUM(presupuesto) AS presupuesto_total
FROM proyecto;

-- Query 5: Proyectos activos en 2025
SELECT nombre, fecha_inicial, fecha_final, presupuesto
FROM proyecto
WHERE YEAR(fecha_inicial) <= 2025 AND (YEAR(fecha_final) >= 2025 OR fecha_final IS NULL);

-- Query 6: Docente con mayor experiencia
SELECT nombres, titulo, anios_experiencia, direccion
FROM docente
ORDER BY anios_experiencia DESC
LIMIT 1;

-- Query 7: Proyectos sin fecha final (en curso)
SELECT nombre, descripcion, fecha_inicial, docente_id_jefe
FROM proyecto
WHERE fecha_final IS NULL;

-- Query 8: Promedio de horas por proyecto
SELECT AVG(horas) AS promedio_horas_por_proyecto
FROM proyecto;

-- Query 9: Listar proyectos con su docente jefe
SELECT p.nombre AS proyecto, p.presupuesto, d.nombres AS docente_jefe, d.titulo
FROM proyecto p
INNER JOIN docente d ON p.docente_id_jefe = d.docente_id
ORDER BY p.nombre;

-- Query 10: Docentes sin proyectos asignados
SELECT d.docente_id, d.nombres, d.tipo_docente
FROM docente d
LEFT JOIN proyecto p ON d.docente_id = p.docente_id_jefe
WHERE p.proyecto_id IS NULL;
