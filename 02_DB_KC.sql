--Creación de tablas DB_keepcoding

CREATE TABLE Alumnos (
    id_alumno INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    id_bootcamp INT NOT NULL, -- Clave foránea
    FOREIGN KEY (id_bootcamp) REFERENCES Bootcamps(id_bootcamp) -- Referencia a la tabla Bootcamps
);
CREATE TABLE Bootcamps (
    id_bootcamp INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE Modulos (
    id_modulo INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    horas INT
);

CREATE TABLE Profesores (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    especializacion VARCHAR(100),
    email VARCHAR(255)
);

CREATE TABLE Bootcamp_Modulo (
    id_bootcamp INT,
    id_modulo INT,
    PRIMARY KEY (id_bootcamp, id_modulo),
    FOREIGN KEY (id_bootcamp) REFERENCES Bootcamps(id_bootcamp),
    FOREIGN KEY (id_modulo) REFERENCES Modulos(id_modulo)
);

CREATE TABLE Profesor_Modulo (
    id_profesor INT,
    id_modulo INT,
    PRIMARY KEY (id_profesor, id_modulo),
    FOREIGN KEY (id_profesor) REFERENCES Profesores(id_profesor),
    FOREIGN KEY (id_modulo) REFERENCES Modulos(id_modulo)
); 

--Insertar datos a DB_keepcoding
-- Insertar datos en la tabla Bootcamps
INSERT INTO Bootcamps (id_bootcamp, nombre, descripcion, fecha_inicio, fecha_fin) VALUES
(1, 'Desarrollo Web Full Stack', 'Aprende HTML, CSS, JavaScript y frameworks modernos de desarrollo web', '2024-01-15', '2024-04-15'),
(2, 'Bootcamp de Ciencia de Datos', 'Domina Python, aprendizaje automático y análisis de datos', '2024-02-01', '2024-05-01');

-- Insertar datos en la tabla Modulos
INSERT INTO Modulos (id_modulo, nombre, descripcion, horas) VALUES
(1, 'Fundamentos de JavaScript', 'Introducción a la programación en JavaScript', 40),
(2, 'Aprendizaje Automático', 'Aprende algoritmos y técnicas en machine learning', 60),
(3, 'HTML y CSS', 'Fundamentos de diseño web con HTML y CSS', 30);

-- Insertar datos en la tabla Profesores
INSERT INTO Profesores (id_profesor, nombre, apellido, especializacion, email) VALUES
(1, 'Laura', 'García', 'Desarrollo Front-end', 'laura.garcia@bootcamp.com'),
(2, 'Carlos', 'Sánchez', 'Aprendizaje Automático', 'carlos.sanchez@bootcamp.com');

-- Insertar datos en la tabla Bootcamp_Modulo
INSERT INTO Bootcamp_Modulo (id_bootcamp, id_modulo) VALUES
(1, 1),
(1, 3),
(2, 2);

-- Insertar datos en la tabla Profesor_Modulo
INSERT INTO Profesor_Modulo (id_profesor, id_modulo) VALUES
(1, 1),
(1, 3),
(2, 2);

-- Insertar datos en la tabla Alumnos
INSERT INTO Alumnos (id_alumno, nombre, apellido, email, id_bootcamp) VALUES
(1, 'Ana', 'Martínez', 'ana.martinez@ejemplo.com', 1),
(2, 'Luis', 'Pérez', 'luis.perez@ejemplo.com', 2),
(3, 'María', 'López', 'maria.lopez@ejemplo.com', 1),
(4, 'Juan', 'Hernández', 'juan.hernandez@ejemplo.com', 2),
(5, 'Elena', 'Ramírez', 'elena.ramirez@ejemplo.com', 1);

--Query usando Join
SELECT A.nombre AS nombre_alumno, A.apellido AS apellido_alumno, B.nombre AS nombre_bootcamp
FROM Alumnos A
JOIN Bootcamps B ON A.id_bootcamp = B.id_bootcamp;