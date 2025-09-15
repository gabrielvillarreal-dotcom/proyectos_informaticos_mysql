-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-09-2025 a las 17:52:58
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: gestion_proyectos
--
DROP DATABASE IF EXISTS gestion_proyectos;
CREATE DATABASE gestion_proyectos CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE gestion_proyectos;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=root@localhost PROCEDURE ActualizarDocente (IN p_docente_id INT, IN p_numero_documento VARCHAR(20), IN p_nombres VARCHAR(100), IN p_titulo VARCHAR(100), IN p_anios_experiencia INT, IN p_direccion VARCHAR(255), IN p_tipo_docente VARCHAR(50))   BEGIN
    UPDATE DOCENTE
    SET 
        numero_documento = p_numero_documento,
        nombres = p_nombres,
        titulo = p_titulo,
        anios_experiencia = p_anios_experiencia,
        direccion = p_direccion,
        tipo_docente = p_tipo_docente
    WHERE docente_id = p_docente_id;
END$$

CREATE DEFINER=root@localhost PROCEDURE ActualizarProyecto (IN p_proyecto_id INT, IN p_nombre VARCHAR(100), IN p_descripcion TEXT, IN p_fecha_inicial DATE, IN p_fecha_final DATE, IN p_presupuesto DECIMAL(15,2), IN p_horas INT, IN p_docente_id_jefe INT)   BEGIN
    UPDATE PROYECTO
    SET 
        nombre = p_nombre,
        descripcion = p_descripcion,
        fecha_inicial = p_fecha_inicial,
        fecha_final = p_fecha_final,
        presupuesto = p_presupuesto,
        horas = p_horas,
        docente_id_jefe = p_docente_id_jefe
    WHERE proyecto_id = p_proyecto_id;
END$$

CREATE DEFINER=root@localhost PROCEDURE EliminarDocente (IN p_docente_id INT)   BEGIN
    DELETE FROM DOCENTE WHERE docente_id = p_docente_id;
END$$

CREATE DEFINER=root@localhost PROCEDURE EliminarProyecto (IN p_proyecto_id INT)   BEGIN
    DELETE FROM PROYECTO WHERE proyecto_id = p_proyecto_id;
END$$

CREATE DEFINER=root@localhost PROCEDURE InsertarDocente (IN p_numero_documento VARCHAR(20), IN p_nombres VARCHAR(100), IN p_titulo VARCHAR(100), IN p_anios_experiencia INT, IN p_direccion VARCHAR(255), IN p_tipo_docente VARCHAR(50))   BEGIN
    INSERT INTO DOCENTE (
        numero_documento, nombres, titulo, anios_experiencia, direccion, tipo_docente
    ) VALUES (
        p_numero_documento, p_nombres, p_titulo, p_anios_experiencia, p_direccion, p_tipo_docente
    );
END$$

CREATE DEFINER=root@localhost PROCEDURE InsertarProyecto (IN p_nombre VARCHAR(100), IN p_descripcion TEXT, IN p_fecha_inicial DATE, IN p_fecha_final DATE, IN p_presupuesto DECIMAL(15,2), IN p_horas INT, IN p_docente_id_jefe INT)   BEGIN
    INSERT INTO PROYECTO (
        nombre, descripcion, fecha_inicial, fecha_final, presupuesto, horas, docente_id_jefe
    ) VALUES (
        p_nombre, p_descripcion, p_fecha_inicial, p_fecha_final, p_presupuesto, p_horas, p_docente_id_jefe
    );
END$$

CREATE DEFINER=root@localhost PROCEDURE ListarDocentes ()   BEGIN
    SELECT * FROM DOCENTE;
END$$

CREATE DEFINER=root@localhost PROCEDURE ListarProyectos ()   BEGIN
    SELECT * FROM PROYECTO;
END$$

--
-- Funciones
--
CREATE DEFINER=root@localhost FUNCTION PromedioExperienciaDocentes () RETURNS DECIMAL(5,2) DETERMINISTIC READS SQL DATA BEGIN
    DECLARE promedio DECIMAL(5,2);
    SELECT AVG(anios_experiencia) INTO promedio
    FROM DOCENTE
    WHERE anios_experiencia IS NOT NULL;
    RETURN IFNULL(promedio, 0);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla copia_actualizados_tablauu
--

CREATE TABLE copia_actualizados_tablauu (
  id int(11) NOT NULL,
  tabla_origen varchar(50) DEFAULT NULL,
  operacion varchar(10) DEFAULT NULL,
  timestamp_operacion timestamp NOT NULL DEFAULT current_timestamp(),
  old_data longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(old_data)),
  new_data longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(new_data))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla copia_actualizados_tablauu
--

INSERT INTO copia_actualizados_tablauu (id, tabla_origen, operacion, timestamp_operacion, old_data, new_data) VALUES
(1, 'DOCENTE', 'UPDATE', '2025-09-11 15:40:54', '{\"docente_id\": 2, \"numero_documento\": \"87654321\", \"nombres\": \"Luisa paz\", \"titulo\": \"Doctora\", \"anios_experiencia\": 15, \"direccion\": \"calle 98\", \"tipo_docente\": \"De planta\"}', '{\"docente_id\": 2, \"numero_documento\": \"87654321\", \"nombres\": \"Luisa paz\", \"titulo\": \"Doctor\", \"anios_experiencia\": 7, \"direccion\": \"crr 98 cll #21\", \"tipo_docente\": \"Titular\"}'),
(2, 'PROYECTO', 'UPDATE', '2025-09-11 16:30:22', '{\"proyecto_id\": 3, \"nombre\": \"Sistema de Biblioteca\", \"descripcion\": \"Desarrollo de sistema de gestión bibliotecaria\", \"fecha_inicial\": \"2025-01-15\", \"fecha_final\": \"2025-06-30\", \"presupuesto\": 7500000.00, \"horas\": 200, \"docente_id_jefe\": 3}', '{\"proyecto_id\": 3, \"nombre\": \"Sistema de Biblioteca Digital\", \"descripcion\": \"Desarrollo de sistema de gestión bibliotecaria con módulo digital\", \"fecha_inicial\": \"2025-01-15\", \"fecha_final\": \"2025-08-31\", \"presupuesto\": 8500000.00, \"horas\": 250, \"docente_id_jefe\": 3}'),
(3, 'DOCENTE', 'UPDATE', '2025-09-11 16:45:10', '{\"docente_id\": 5, \"numero_documento\": \"1122334455\", \"nombres\": \"Carlos Ruiz\", \"titulo\": \"Magister\", \"anios_experiencia\": 8, \"direccion\": \"Av. Principal 123\", \"tipo_docente\": \"Titular\"}', '{\"docente_id\": 5, \"numero_documento\": \"1122334455\", \"nombres\": \"Carlos Ruiz Méndez\", \"titulo\": \"Doctor\", \"anios_experiencia\": 10, \"direccion\": \"Av. Principal 123-45\", \"tipo_docente\": \"Titular\"}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla copia_eliminados_tabladd
--

CREATE TABLE copia_eliminados_tabladd (
  id int(11) NOT NULL,
  tabla_origen varchar(50) DEFAULT NULL,
  operacion varchar(10) DEFAULT NULL,
  timestamp_operacion timestamp NOT NULL DEFAULT current_timestamp(),
  data_eliminado longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(data_eliminado))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla copia_eliminados_tabladd
--

INSERT INTO copia_eliminados_tabladd (id, tabla_origen, operacion, timestamp_operacion, data_eliminado) VALUES
(1, 'DOCENTE', 'DELETE', '2025-09-11 15:42:24', '{\"docente_id\": 2, \"numero_documento\": \"87654321\", \"nombres\": \"Luisa paz\", \"titulo\": \"Doctor\", \"anios_experiencia\": 7, \"direccion\": \"crr 98 cll #21\", \"tipo_docente\": \"Titular\"}'),
(2, 'PROYECTO', 'DELETE', '2025-09-11 16:35:47', '{\"proyecto_id\": 6, \"nombre\": \"App Móvil Estudiantil\", \"descripcion\": \"Desarrollo de aplicación móvil para gestión estudiantil\", \"fecha_inicial\": \"2025-03-01\", \"fecha_final\": \"2025-09-30\", \"presupuesto\": 6000000.00, \"horas\": 180, \"docente_id_jefe\": 4}');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla docente
--

CREATE TABLE docente (
  docente_id int(11) NOT NULL,
  numero_documento varchar(20) NOT NULL,
  nombres varchar(100) NOT NULL,
  titulo varchar(100) DEFAULT NULL,
  anios_experiencia int(11) DEFAULT NULL,
  direccion varchar(255) DEFAULT NULL,
  tipo_docente varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla docente
--

INSERT INTO docente (docente_id, numero_documento, nombres, titulo, anios_experiencia, direccion, tipo_docente) VALUES
(1, '123456789', 'Ana Gómez', 'Ingeniera', 5, 'Calle 95', 'Titular'),
(3, '987654321', 'Roberto Sánchez', 'Magister en Educación', 12, 'Carrera 45 #67-89', 'Titular'),
(4, '555444333', 'María Rodríguez', 'Doctora en Ciencias', 15, 'Avenida Siempre Viva 742', 'Titular'),
(5, '1122334455', 'Carlos Ruiz Méndez', 'Doctor', 10, 'Av. Principal 123-45', 'Titular'),
(6, '6677889900', 'Laura Martínez', 'Magister', 7, 'Calle 80 #23-45', 'Asociado'),
(7, '9988776655', 'Javier López', 'Especialista', 4, 'Diagonal 25 #34-56', 'Asistente'),
(8, '4433221100', 'Sofía Ramírez', 'Ingeniera', 6, 'Transversal 12 #78-90', 'Titular'),
(9, '7766554433', 'Diego Herrera', 'Magister', 9, 'Carrera 68 #12-34', 'Asociado'),
(10, '3344556677', 'Carmen Vargas', 'Doctora', 18, 'Avenida 30 #45-67', 'Titular');

--
-- Disparadores docente
--
DELIMITER $$
CREATE TRIGGER tr_actualiza_docente AFTER UPDATE ON docente FOR EACH ROW BEGIN
    INSERT INTO copia_actualizados_tablaUU (tabla_origen, operacion, old_data, new_data)
    VALUES (
        'DOCENTE',
        'UPDATE',
        JSON_OBJECT('docente_id', OLD.docente_id, 'numero_documento', OLD.numero_documento, 'nombres', OLD.nombres, 'titulo', OLD.titulo, 'anios_experiencia', OLD.anios_experiencia, 'direccion', OLD.direccion, 'tipo_docente', OLD.tipo_docente),
        JSON_OBJECT('docente_id', NEW.docente_id, 'numero_documento', NEW.numero_documento, 'nombres', NEW.nombres, 'titulo', NEW.titulo, 'anios_experiencia', NEW.anios_experiencia, 'direccion', NEW.direccion, 'tipo_docente', NEW.tipo_docente)
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER tr_elimina_docente BEFORE DELETE ON docente FOR EACH ROW BEGIN
    INSERT INTO copia_eliminados_tablaDD (tabla_origen, operacion, data_eliminado)
    VALUES (
        'DOCENTE',
        'DELETE',
        JSON_OBJECT('docente_id', OLD.docente_id, 'numero_documento', OLD.numero_documento, 'nombres', OLD.nombres, 'titulo', OLD.titulo, 'anios_experiencia', OLD.anios_experiencia, 'direccion', OLD.direccion, 'tipo_docente', OLD.tipo_docente)
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla proyecto
--

CREATE TABLE proyecto (
  proyecto_id int(11) NOT NULL,
  nombre varchar(100) NOT NULL,
  descripcion text DEFAULT NULL,
  fecha_inicial date NOT NULL,
  fecha_final date DEFAULT NULL,
  presupuesto decimal(15,2) DEFAULT NULL,
  horas int(11) DEFAULT NULL,
  docente_id_jefe int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla proyecto
--

INSERT INTO proyecto (proyecto_id, nombre, descripcion, fecha_inicial, fecha_final, presupuesto, horas, docente_id_jefe) VALUES
(1, 'Proyectos Informaticos', 'Gestión de proyectos informáticos para sus empresas aliadas', '2025-09-11', '2025-12-15', 5000000.00, 120, 1),
(2, 'Plataforma E-Learning', 'Desarrollo de plataforma de educación virtual para la institución', '2025-02-10', '2025-11-30', 12000000.00, 350, 4),
(3, 'Sistema de Biblioteca Digital', 'Desarrollo de sistema de gestión bibliotecaria con módulo digital', '2025-01-15', '2025-08-31', 8500000.00, 250, 3),
(4, 'Investigación en IA Educativa', 'Proyecto de investigación sobre aplicaciones de inteligencia artificial en educación', '2025-03-01', '2026-02-28', 15000000.00, 500, 10),
(5, 'Rediseño Plataforma Web', 'Modernización y rediseño de la plataforma web institucional', '2025-05-20', '2025-10-15', 7000000.00, 200, 8),
(7, 'Sistema de Gestión Laboratorios', 'Desarrollo de software para gestión de laboratorios de computación', '2025-04-10', '2025-09-30', 5500000.00, 160, 6),
(8, 'Proyecto Robótica Educativa', 'Implementación de programa de robótica para estudiantes', '2025-06-01', '2025-12-20', 9500000.00, 280, 5),
(9, 'Plataforma de Cursos Abiertos', 'Desarrollo de plataforma para cursos en línea abiertos al público', '2025-07-15', '2026-01-31', 11000000.00, 320, 9),
(10, 'App de Comunicación Institucional', 'Aplicación móvil para comunicación entre estudiantes y docentes', '2025-08-01', '2026-03-15', 8000000.00, 240, 7);

--
-- Disparadores proyecto
--
DELIMITER $$
CREATE TRIGGER tr_actualiza_proyecto AFTER UPDATE ON proyecto FOR EACH ROW BEGIN
    INSERT INTO copia_actualizados_tablaUU (tabla_origen, operacion, old_data, new_data)
    VALUES (
        'PROYECTO',
        'UPDATE',
        JSON_OBJECT('proyecto_id', OLD.proyecto_id, 'nombre', OLD.nombre, 'descripcion', OLD.descripcion, 'fecha_inicial', OLD.fecha_inicial, 'fecha_final', OLD.fecha_final, 'presupuesto', OLD.presupuesto, 'horas', OLD.horas, 'docente_id_jefe', OLD.docente_id_jefe),
        JSON_OBJECT('proyecto_id', NEW.proyecto_id, 'nombre', NEW.nombre, 'descripcion', NEW.descripcion, 'fecha_inicial', NEW.fecha_inicial, 'fecha_final', NEW.fecha_final, 'presupuesto', NEW.presupuesto, 'horas', NEW.horas, 'docente_id_jefe', NEW.docente_id_jefe)
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER tr_elimina_proyecto BEFORE DELETE ON proyecto FOR EACH ROW BEGIN
    INSERT INTO copia_eliminados_tablaDD (tabla_origen, operacion, data_eliminado)
    VALUES (
        'PROYECTO',
        'DELETE',
        JSON_OBJECT('proyecto_id', OLD.proyecto_id, 'nombre', OLD.nombre, 'descripcion', OLD.descripcion, 'fecha_inicial', OLD.fecha_inicial, 'fecha_final', OLD.fecha_final, 'presupuesto', OLD.presupuesto, 'horas', OLD.horas, 'docente_id_jefe', OLD.docente_id_jefe)
    );
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla copia_actualizados_tablauu
--
ALTER TABLE copia_actualizados_tablauu
  ADD PRIMARY KEY (id);

--
-- Indices de la tabla copia_eliminados_tabladd
--
ALTER TABLE copia_eliminados_tabladd
  ADD PRIMARY KEY (id);

--
-- Indices de la tabla docente
--
ALTER TABLE docente
  ADD PRIMARY KEY (docente_id),
  ADD UNIQUE KEY numero_documento (numero_documento);

--
-- Indices de la tabla proyecto
--
ALTER TABLE proyecto
  ADD PRIMARY KEY (proyecto_id),
  ADD KEY docente_id_jefe (docente_id_jefe);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla copia_actualizados_tablauu
--
ALTER TABLE copia_actualizados_tablauu
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla copia_eliminados_tabladd
--
ALTER TABLE copia_eliminados_tabladd
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla docente
--
ALTER TABLE docente
  MODIFY docente_id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla proyecto
--
ALTER TABLE proyecto
  MODIFY proyecto_id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla proyecto
--
ALTER TABLE proyecto
  ADD CONSTRAINT proyecto_ibfk_1 FOREIGN KEY (docente_id_jefe) REFERENCES docente (docente_id);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
