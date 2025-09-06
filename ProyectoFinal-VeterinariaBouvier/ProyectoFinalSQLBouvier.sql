CREATE DATABASE VeterinariaBouvier;
USE VeterinariaBouvier;

-- Tabla: propietario
CREATE TABLE propietario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion VARCHAR(100)
);

-- Tabla: especie
CREATE TABLE especie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla: raza
CREATE TABLE raza (
    id INT AUTO_INCREMENT PRIMARY KEY,
    especie_id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    FOREIGN KEY (especie_id) REFERENCES especie(id)
);

-- Tabla: mascota
CREATE TABLE mascota (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
    peso DECIMAL(5,2),
    especie_id INT NOT NULL,
    raza_id INT NOT NULL,
    propietario_id INT NOT NULL,
    FOREIGN KEY (especie_id) REFERENCES especie(id),
    FOREIGN KEY (raza_id) REFERENCES raza(id),
    FOREIGN KEY (propietario_id) REFERENCES propietario(id)
);

-- Tabla: veterinario
CREATE TABLE veterinario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    matricula VARCHAR(30),
    telefono VARCHAR(20),
    email VARCHAR(100)
);

-- Tabla: servicio
CREATE TABLE servicio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    precio DECIMAL(10,2)
);

-- Tabla: cita
CREATE TABLE cita (
    id INT AUTO_INCREMENT PRIMARY KEY,
    veterinario_id INT NOT NULL,
    mascota_id INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    servicio_id INT NOT NULL,
    observaciones VARCHAR(200),
    FOREIGN KEY (veterinario_id) REFERENCES veterinario(id),
    FOREIGN KEY (mascota_id) REFERENCES mascota(id),
    FOREIGN KEY (servicio_id) REFERENCES servicio(id)
);

-- Tabla: historial_medico
CREATE TABLE historial_medico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    veterinario_id INT NOT NULL,
    mascota_id INT NOT NULL,
    fecha DATE NOT NULL,
    descripcion VARCHAR(200),
    FOREIGN KEY (veterinario_id) REFERENCES veterinario(id),
    FOREIGN KEY (mascota_id) REFERENCES mascota(id)
);

-- Tabla: vacuna
CREATE TABLE vacuna (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200)
);

-- Tabla: vacuna_aplicada
CREATE TABLE vacuna_aplicada (
    id INT AUTO_INCREMENT PRIMARY KEY,
    veterinario_id INT NOT NULL,
    mascota_id INT NOT NULL,
    vacuna_id INT NOT NULL,
    fecha_aplicacion DATE NOT NULL,
    observaciones VARCHAR(200),
    FOREIGN KEY (veterinario_id) REFERENCES veterinario(id),
    FOREIGN KEY (mascota_id) REFERENCES mascota(id),
    FOREIGN KEY (vacuna_id) REFERENCES vacuna(id)
);

-- Fin del script de creación de la base de datos VeterinariaBouvier