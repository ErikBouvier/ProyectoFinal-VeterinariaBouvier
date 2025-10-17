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

-- ========================================
-- NUEVAS TABLAS - ENTREGA FINAL
-- ========================================

-- Tabla: proveedor
CREATE TABLE proveedor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion VARCHAR(150),
    rubro VARCHAR(50)
);

-- Tabla: inventario
CREATE TABLE inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    stock_actual INT NOT NULL DEFAULT 0,
    stock_minimo INT NOT NULL DEFAULT 5,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_vencimiento DATE,
    proveedor_id INT NOT NULL,
    FOREIGN KEY (proveedor_id) REFERENCES proveedor(id)
);

-- Tabla: empleado
CREATE TABLE empleado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_ingreso DATE NOT NULL,
    salario DECIMAL(10,2),
    horario VARCHAR(50)
);

-- Tabla: facturacion
CREATE TABLE facturacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    propietario_id INT NOT NULL,
    fecha_factura DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    descuento DECIMAL(5,2) DEFAULT 0.00,
    forma_pago ENUM('EFECTIVO', 'TARJETA', 'TRANSFERENCIA', 'CHEQUE') NOT NULL,
    estado_pago ENUM('PENDIENTE', 'PAGADO', 'VENCIDO') NOT NULL DEFAULT 'PENDIENTE',
    fecha_vencimiento DATE,
    FOREIGN KEY (propietario_id) REFERENCES propietario(id)
);

-- Tabla: recordatorio
CREATE TABLE recordatorio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mascota_id INT NOT NULL,
    tipo_recordatorio ENUM('VACUNA', 'CONTROL', 'TRATAMIENTO', 'CIRUGIA_SEGUIMIENTO', 'OTROS') NOT NULL,
    fecha_programada DATE NOT NULL,
    mensaje TEXT,
    estado ENUM('PENDIENTE', 'ENVIADO', 'COMPLETADO', 'CANCELADO') NOT NULL DEFAULT 'PENDIENTE',
    fecha_enviado DATETIME,
    FOREIGN KEY (mascota_id) REFERENCES mascota(id)
);

-- ========================================
-- ÍNDICES ADICIONALES PARA OPTIMIZACIÓN
-- ========================================

-- Índices para mejorar rendimiento de consultas frecuentes
CREATE INDEX idx_inventario_categoria ON inventario(categoria);
CREATE INDEX idx_inventario_stock ON inventario(stock_actual, stock_minimo);
CREATE INDEX idx_inventario_vencimiento ON inventario(fecha_vencimiento);
CREATE INDEX idx_facturacion_fecha ON facturacion(fecha_factura);
CREATE INDEX idx_facturacion_estado ON facturacion(estado_pago);
CREATE INDEX idx_recordatorio_fecha ON recordatorio(fecha_programada);
CREATE INDEX idx_recordatorio_estado ON recordatorio(estado);
CREATE INDEX idx_empleado_cargo ON empleado(cargo);

