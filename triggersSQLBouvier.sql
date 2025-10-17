USE VeterinariaBouvier;

-- ========================================
-- TRIGGERS (2 triggers para automatización y control)
-- ========================================

-- Crear tabla de auditoría para historial médico
CREATE TABLE IF NOT EXISTS auditoria_historial_medico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    accion VARCHAR(20) NOT NULL,
    historial_id INT NOT NULL,
    mascota_id_anterior INT,
    mascota_id_nuevo INT,
    veterinario_id_anterior INT,
    veterinario_id_nuevo INT,
    fecha_anterior DATE,
    fecha_nueva DATE,
    descripcion_anterior TEXT,
    descripcion_nueva TEXT,
    usuario_modificacion VARCHAR(100),
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_modificacion VARCHAR(45)
);

-- Trigger 1: Auditoría de cambios en historial médico
DROP TRIGGER IF EXISTS tr_auditoria_historial_medico;
DELIMITER //
CREATE TRIGGER tr_auditoria_historial_medico
AFTER UPDATE ON historial_medico
FOR EACH ROW
BEGIN
    -- Registrar la modificación en la tabla de auditoría
    INSERT INTO auditoria_historial_medico (
        accion,
        historial_id,
        mascota_id_anterior,
        mascota_id_nuevo,
        veterinario_id_anterior,
        veterinario_id_nuevo,
        fecha_anterior,
        fecha_nueva,
        descripcion_anterior,
        descripcion_nueva,
        usuario_modificacion,
        ip_modificacion
    ) VALUES (
        'UPDATE',
        NEW.id,
        OLD.mascota_id,
        NEW.mascota_id,
        OLD.veterinario_id,
        NEW.veterinario_id,
        OLD.fecha,
        NEW.fecha,
        OLD.descripcion,
        NEW.descripcion,
        USER(),
        CONNECTION_ID()
    );
    
    -- Log adicional si se cambió información crítica
    IF OLD.mascota_id != NEW.mascota_id OR OLD.veterinario_id != NEW.veterinario_id THEN
        INSERT INTO auditoria_historial_medico (
            accion,
            historial_id,
            descripcion_nueva,
            usuario_modificacion
        ) VALUES (
            'CRITICAL_CHANGE',
            NEW.id,
            'ALERTA: Se modificó mascota o veterinario en historial médico',
            USER()
        );
    END IF;
END//
DELIMITER ;

-- Trigger 2: Validación de citas para evitar conflictos de horario
DROP TRIGGER IF EXISTS tr_validacion_citas;
DELIMITER //
CREATE TRIGGER tr_validacion_citas
BEFORE INSERT ON cita
FOR EACH ROW
BEGIN
    DECLARE conflicto_count INT DEFAULT 0;
    DECLARE mensaje_error VARCHAR(255);
    
    -- Verificar si el veterinario ya tiene una cita a esa hora
    SELECT COUNT(*) INTO conflicto_count
    FROM cita 
    WHERE veterinario_id = NEW.veterinario_id 
    AND fecha = NEW.fecha 
    AND hora = NEW.hora;
    
    -- Si hay conflicto, generar error
    IF conflicto_count > 0 THEN
        SET mensaje_error = CONCAT(
            'ERROR: El veterinario ya tiene una cita programada el ',
            NEW.fecha, ' a las ', NEW.hora,
            '. No se pueden programar citas simultáneas.'
        );
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
    END IF;
    
    -- Validar que la fecha de la cita no sea en el pasado
    IF NEW.fecha < CURDATE() THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'ERROR: No se pueden programar citas en fechas pasadas.';
    END IF;
    
    -- Validar horario de atención (8:00 AM a 6:00 PM)
    IF NEW.hora < '08:00:00' OR NEW.hora > '18:00:00' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'ERROR: Las citas solo pueden programarse entre 8:00 AM y 6:00 PM.';
    END IF;
    
    -- Validar que no sea domingo (día 1 = domingo en MySQL)
    IF DAYOFWEEK(NEW.fecha) = 1 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'ERROR: La veterinaria no atiende los domingos.';
    END IF;
    
    -- Auto-completar observaciones si están vacías
    IF NEW.observaciones IS NULL OR NEW.observaciones = '' THEN
        SET NEW.observaciones = CONCAT(
            'Cita programada automáticamente el ', 
            NOW(), ' por el sistema'
        );
    END IF;
    
END//
DELIMITER ;

