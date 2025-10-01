USE VeterinariaBouvier;

-- Vista 1: Estadísticas de vacunación por especie, tipo y año
CREATE OR REPLACE VIEW vw_estadisticas_vacunacion AS
SELECT 
    YEAR(va.fecha_aplicacion) AS año_aplicacion,
    e.nombre AS especie,
    v.nombre AS tipo_vacuna,
    COUNT(*) AS cantidad_aplicaciones,
    COUNT(DISTINCT va.mascota_id) AS mascotas_vacunadas,
    CONCAT(
        ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY YEAR(va.fecha_aplicacion), e.nombre)), 2), 
        '%'
    ) AS porcentaje_por_especie
FROM vacuna_aplicada va
INNER JOIN mascota m ON va.mascota_id = m.id
INNER JOIN especie e ON m.especie_id = e.id
INNER JOIN vacuna v ON va.vacuna_id = v.id
INNER JOIN veterinario vet ON va.veterinario_id = vet.id
GROUP BY 
    YEAR(va.fecha_aplicacion),
    e.id,
    e.nombre,
    v.id,
    v.nombre
HAVING COUNT(*) > 0
ORDER BY 
    año_aplicacion DESC,
    e.nombre,
    cantidad_aplicaciones DESC;

-- Vista 2: Ingresos mensuales por tratamientos e internaciones
CREATE OR REPLACE VIEW vw_ingresos_mensuales_tratamientos AS
SELECT 
    año,
    mes,
    CASE mes
        WHEN 1 THEN 'Enero'
        WHEN 2 THEN 'Febrero'
        WHEN 3 THEN 'Marzo'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Mayo'
        WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Septiembre'
        WHEN 10 THEN 'Octubre'
        WHEN 11 THEN 'Noviembre'
        WHEN 12 THEN 'Diciembre'
    END AS nombre_mes,
    CONCAT(año, '-', LPAD(mes, 2, '0')) AS periodo,
    
    -- Ingresos por Tratamientos
    ingresos_tratamientos,
    cantidad_tratamientos,
    
    -- Ingresos por Internaciones
    ingresos_internaciones,
    cantidad_internaciones,
    
    -- Totales
    total_ingresos_mes,
    total_servicios_mes,
    
    -- Promedio por servicio
    promedio_tratamiento,
    promedio_internacion,
    
    -- Porcentaje de ingresos
    CONCAT(
        ROUND(
            (ingresos_tratamientos * 100.0) / 
            NULLIF(total_ingresos_mes, 0), 
            2
        ), '%'
    ) AS porcentaje_tratamientos,
    CONCAT(
        ROUND(
            (ingresos_internaciones * 100.0) / 
            NULLIF(total_ingresos_mes, 0), 
            2
        ), '%'
    ) AS porcentaje_internaciones

FROM (
    SELECT 
        YEAR(c.fecha) AS año,
        MONTH(c.fecha) AS mes,
        
        -- Ingresos por Tratamientos
        SUM(CASE WHEN s.nombre = 'Tratamiento' THEN s.precio ELSE 0 END) AS ingresos_tratamientos,
        COUNT(CASE WHEN s.nombre = 'Tratamiento' THEN 1 END) AS cantidad_tratamientos,
        
        -- Ingresos por Internaciones
        SUM(CASE WHEN s.nombre = 'Internacion' THEN s.precio ELSE 0 END) AS ingresos_internaciones,
        COUNT(CASE WHEN s.nombre = 'Internacion' THEN 1 END) AS cantidad_internaciones,
        
        -- Totales
        SUM(CASE WHEN s.nombre IN ('Tratamiento', 'Internacion') THEN s.precio ELSE 0 END) AS total_ingresos_mes,
        COUNT(CASE WHEN s.nombre IN ('Tratamiento', 'Internacion') THEN 1 END) AS total_servicios_mes,
        
        -- Promedio por servicio
        ROUND(AVG(CASE WHEN s.nombre = 'Tratamiento' THEN s.precio END), 2) AS promedio_tratamiento,
        ROUND(AVG(CASE WHEN s.nombre = 'Internacion' THEN s.precio END), 2) AS promedio_internacion
        
    FROM cita c
    INNER JOIN servicio s ON c.servicio_id = s.id
    INNER JOIN mascota m ON c.mascota_id = m.id
    INNER JOIN propietario p ON m.propietario_id = p.id
    INNER JOIN veterinario v ON c.veterinario_id = v.id
    WHERE s.nombre IN ('Tratamiento', 'Internacion')
    GROUP BY 
        YEAR(c.fecha),
        MONTH(c.fecha)
    HAVING SUM(CASE WHEN s.nombre IN ('Tratamiento', 'Internacion') THEN s.precio ELSE 0 END) > 0
) AS datos_mensuales
ORDER BY 
    año DESC,
    mes DESC;

-- Vista 3: Promedio de mascotas por zona de Montevideo y especie
CREATE OR REPLACE VIEW vw_mascotas_por_zona_montevideo AS
SELECT 
    -- Extracción de zona de la dirección
    CASE 
        WHEN p.direccion LIKE '%Pocitos%' THEN 'Pocitos'
        WHEN p.direccion LIKE '%Punta Carretas%' THEN 'Punta Carretas'
        WHEN p.direccion LIKE '%Centro%' THEN 'Centro'
        WHEN p.direccion LIKE '%Tres Cruces%' THEN 'Tres Cruces'
        WHEN p.direccion LIKE '%Malvín%' THEN 'Malvín'
        WHEN p.direccion LIKE '%Parque Rodó%' THEN 'Parque Rodó'
        WHEN p.direccion LIKE '%La Blanqueada%' THEN 'La Blanqueada'
        WHEN p.direccion LIKE '%Reducto%' THEN 'Reducto'
        WHEN p.direccion LIKE '%Carrasco%' THEN 'Carrasco'
        WHEN p.direccion LIKE '%Cordón%' THEN 'Cordón'
        WHEN p.direccion LIKE '%Barrio Sur%' THEN 'Barrio Sur'
        WHEN p.direccion LIKE '%Villa Dolores%' THEN 'Villa Dolores'
        WHEN p.direccion LIKE '%Aguada%' THEN 'Aguada'
        WHEN p.direccion LIKE '%Atahualpa%' THEN 'Atahualpa'
        ELSE 'Otras Zonas'
    END AS zona_montevideo,
    
    -- Conteo por especies
    COUNT(CASE WHEN e.nombre = 'Canino' THEN 1 END) AS total_perros,
    COUNT(CASE WHEN e.nombre = 'Felino' THEN 1 END) AS total_gatos,
    COUNT(CASE WHEN e.nombre = 'Otras' THEN 1 END) AS total_otras,
    
    -- Total de mascotas y propietarios
    COUNT(m.id) AS total_mascotas,
    COUNT(DISTINCT p.id) AS total_propietarios,
    
    -- Promedios por propietario en la zona
    ROUND(AVG(CASE WHEN e.nombre = 'Canino' THEN 1.0 ELSE 0 END), 2) AS promedio_perros_por_propietario,
    ROUND(AVG(CASE WHEN e.nombre = 'Felino' THEN 1.0 ELSE 0 END), 2) AS promedio_gatos_por_propietario,
    ROUND(AVG(CASE WHEN e.nombre = 'Otras' THEN 1.0 ELSE 0 END), 2) AS promedio_otras_por_propietario,
    
    -- Promedio total de mascotas por propietario
    ROUND(COUNT(m.id) * 1.0 / COUNT(DISTINCT p.id), 2) AS promedio_mascotas_por_propietario,
    
    -- Porcentajes por especie en la zona
    CONCAT(ROUND((COUNT(CASE WHEN e.nombre = 'Canino' THEN 1 END) * 100.0) / COUNT(m.id), 2), '%') AS porcentaje_perros,
    CONCAT(ROUND((COUNT(CASE WHEN e.nombre = 'Felino' THEN 1 END) * 100.0) / COUNT(m.id), 2), '%') AS porcentaje_gatos,
    CONCAT(ROUND((COUNT(CASE WHEN e.nombre = 'Otras' THEN 1 END) * 100.0) / COUNT(m.id), 2), '%') AS porcentaje_otras,
    
    -- Peso promedio por especie en la zona
    ROUND(AVG(CASE WHEN e.nombre = 'Canino' THEN m.peso END), 2) AS peso_promedio_perros,
    ROUND(AVG(CASE WHEN e.nombre = 'Felino' THEN m.peso END), 2) AS peso_promedio_gatos,
    ROUND(AVG(CASE WHEN e.nombre = 'Otras' THEN m.peso END), 2) AS peso_promedio_otras

FROM propietario p
INNER JOIN mascota m ON p.id = m.propietario_id
INNER JOIN especie e ON m.especie_id = e.id
INNER JOIN raza r ON m.raza_id = r.id
GROUP BY 
    CASE 
        WHEN p.direccion LIKE '%Pocitos%' THEN 'Pocitos'
        WHEN p.direccion LIKE '%Punta Carretas%' THEN 'Punta Carretas'
        WHEN p.direccion LIKE '%Centro%' THEN 'Centro'
        WHEN p.direccion LIKE '%Tres Cruces%' THEN 'Tres Cruces'
        WHEN p.direccion LIKE '%Malvín%' THEN 'Malvín'
        WHEN p.direccion LIKE '%Parque Rodó%' THEN 'Parque Rodó'
        WHEN p.direccion LIKE '%La Blanqueada%' THEN 'La Blanqueada'
        WHEN p.direccion LIKE '%Reducto%' THEN 'Reducto'
        WHEN p.direccion LIKE '%Carrasco%' THEN 'Carrasco'
        WHEN p.direccion LIKE '%Cordón%' THEN 'Cordón'
        WHEN p.direccion LIKE '%Barrio Sur%' THEN 'Barrio Sur'
        WHEN p.direccion LIKE '%Villa Dolores%' THEN 'Villa Dolores'
        WHEN p.direccion LIKE '%Aguada%' THEN 'Aguada'
        WHEN p.direccion LIKE '%Atahualpa%' THEN 'Atahualpa'
        ELSE 'Otras Zonas'
    END
HAVING total_mascotas > 0
ORDER BY 
    total_mascotas DESC,
    promedio_mascotas_por_propietario DESC;

-- ========================================
-- FUNCIONES (2 funciones que retornan un único valor)
-- ========================================

-- Función 1: Calcular edad de mascota en formato legible
DROP FUNCTION IF EXISTS fn_calcular_edad_mascota;
DELIMITER //
CREATE FUNCTION fn_calcular_edad_mascota(mascota_id INT)
RETURNS VARCHAR(50)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE fecha_nac DATE;
    DECLARE años INT;
    DECLARE meses INT;
    DECLARE resultado VARCHAR(50);
    
    -- Obtener fecha de nacimiento
    SELECT fecha_nacimiento INTO fecha_nac 
    FROM mascota 
    WHERE id = mascota_id;
    
    -- Si no existe la mascota o no tiene fecha de nacimiento
    IF fecha_nac IS NULL THEN
        RETURN 'Fecha no disponible';
    END IF;
    
    -- Calcular años completos
    SET años = TIMESTAMPDIFF(YEAR, fecha_nac, CURDATE());
    
    -- Calcular meses adicionales
    SET meses = TIMESTAMPDIFF(MONTH, fecha_nac, CURDATE()) % 12;
    
    -- Formatear resultado
    IF años > 0 AND meses > 0 THEN
        SET resultado = CONCAT(años, ' años y ', meses, ' meses');
    ELSEIF años > 0 AND meses = 0 THEN
        SET resultado = CONCAT(años, ' años');
    ELSEIF años = 0 AND meses > 0 THEN
        SET resultado = CONCAT(meses, ' meses');
    ELSE
        SET resultado = 'Menos de 1 mes';
    END IF;
    
    RETURN resultado;
END//
DELIMITER ;

-- Función 2: Calcular costo total de servicios por mascota en un año específico
DROP FUNCTION IF EXISTS fn_costo_total_mascota_año;
DELIMITER //
CREATE FUNCTION fn_costo_total_mascota_año(mascota_id INT, año_consulta INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE costo_total DECIMAL(10,2) DEFAULT 0.00;
    
    -- Calcular suma de servicios del año especificado
    SELECT COALESCE(SUM(s.precio), 0.00)
    INTO costo_total
    FROM cita c
    INNER JOIN servicio s ON c.servicio_id = s.id
    WHERE c.mascota_id = mascota_id 
    AND YEAR(c.fecha) = año_consulta;
    
    RETURN costo_total;
END//
DELIMITER ;

-- ========================================
-- STORED PROCEDURES (2 SP que retornan conjuntos de datos)
-- ========================================

-- SP 1: Obtener historial completo de una mascota
DROP PROCEDURE IF EXISTS sp_historial_completo_mascota;
DELIMITER //
CREATE PROCEDURE sp_historial_completo_mascota(IN mascota_id INT)
BEGIN
    -- Declarar variables para manejo de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Información básica de la mascota
    SELECT 
        m.id AS mascota_id,
        m.nombre AS mascota_nombre,
        fn_calcular_edad_mascota(m.id) AS edad_actual,
        m.fecha_nacimiento,
        m.peso AS peso_actual,
        e.nombre AS especie,
        r.nombre AS raza,
        p.nombre AS propietario_nombre,
        p.apellido AS propietario_apellido,
        p.telefono AS propietario_telefono,
        p.email AS propietario_email,
        p.direccion AS propietario_direccion
    FROM mascota m
    INNER JOIN especie e ON m.especie_id = e.id
    INNER JOIN raza r ON m.raza_id = r.id
    INNER JOIN propietario p ON m.propietario_id = p.id
    WHERE m.id = mascota_id;

    -- Historial médico completo
    SELECT 
        hm.fecha AS fecha_consulta,
        hm.descripcion AS descripcion_medica,
        vet.nombre AS veterinario_nombre,
        vet.apellido AS veterinario_apellido,
        vet.matricula AS veterinario_matricula,
        'Historial Médico' AS tipo_registro
    FROM historial_medico hm
    INNER JOIN veterinario vet ON hm.veterinario_id = vet.id
    WHERE hm.mascota_id = mascota_id
    
    UNION ALL
    
    -- Citas y servicios
    SELECT 
        c.fecha AS fecha_consulta,
        CONCAT('Servicio: ', s.nombre, ' - ', COALESCE(c.observaciones, 'Sin observaciones')) AS descripcion_medica,
        vet.nombre AS veterinario_nombre,
        vet.apellido AS veterinario_apellido,
        vet.matricula AS veterinario_matricula,
        'Cita/Servicio' AS tipo_registro
    FROM cita c
    INNER JOIN servicio s ON c.servicio_id = s.id
    INNER JOIN veterinario vet ON c.veterinario_id = vet.id
    WHERE c.mascota_id = mascota_id
    
    UNION ALL
    
    -- Vacunas aplicadas
    SELECT 
        va.fecha_aplicacion AS fecha_consulta,
        CONCAT('Vacuna: ', v.nombre, ' - ', COALESCE(va.observaciones, 'Sin observaciones')) AS descripcion_medica,
        vet.nombre AS veterinario_nombre,
        vet.apellido AS veterinario_apellido,
        vet.matricula AS veterinario_matricula,
        'Vacunación' AS tipo_registro
    FROM vacuna_aplicada va
    INNER JOIN vacuna v ON va.vacuna_id = v.id
    INNER JOIN veterinario vet ON va.veterinario_id = vet.id
    WHERE va.mascota_id = mascota_id
    
    ORDER BY fecha_consulta DESC;

    -- Resumen financiero de la mascota
    SELECT 
        YEAR(c.fecha) AS año,
        COUNT(*) AS total_servicios,
        SUM(s.precio) AS total_gastado,
        AVG(s.precio) AS promedio_por_servicio,
        MIN(s.precio) AS servicio_mas_barato,
        MAX(s.precio) AS servicio_mas_caro
    FROM cita c
    INNER JOIN servicio s ON c.servicio_id = s.id
    WHERE c.mascota_id = mascota_id
    GROUP BY YEAR(c.fecha)
    ORDER BY año DESC;
END//
DELIMITER ;

-- SP 2: Agenda diaria del veterinario
DROP PROCEDURE IF EXISTS sp_agenda_diaria_veterinario;
DELIMITER //
CREATE PROCEDURE sp_agenda_diaria_veterinario(IN veterinario_id INT, IN fecha_consulta DATE)
BEGIN
    -- Declarar variables
    DECLARE total_citas INT DEFAULT 0;
    DECLARE ingresos_dia DECIMAL(10,2) DEFAULT 0.00;
    
    -- Declarar manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Información del veterinario
    SELECT 
        v.id AS veterinario_id,
        CONCAT(v.nombre, ' ', v.apellido) AS veterinario_completo,
        v.matricula,
        v.telefono,
        v.email,
        fecha_consulta AS fecha_agenda
    FROM veterinario v
    WHERE v.id = veterinario_id;

    -- Agenda detallada del día
    SELECT 
        c.hora AS hora_cita,
        c.fecha AS fecha_cita,
        m.nombre AS mascota_nombre,
        CONCAT(e.nombre, ' - ', r.nombre) AS especie_raza,
        fn_calcular_edad_mascota(m.id) AS edad_mascota,
        s.nombre AS servicio_solicitado,
        s.precio AS costo_servicio,
        CONCAT(p.nombre, ' ', p.apellido) AS propietario_completo,
        p.telefono AS propietario_telefono,
        p.email AS propietario_email,
        COALESCE(c.observaciones, 'Sin observaciones especiales') AS observaciones_cita,
        
        -- Estado de la cita basado en la hora
        CASE 
            WHEN TIME(NOW()) > c.hora AND DATE(NOW()) = c.fecha THEN 'Completada'
            WHEN TIME(NOW()) < c.hora AND DATE(NOW()) = c.fecha THEN 'Pendiente'
            WHEN DATE(NOW()) > c.fecha THEN 'Vencida'
            ELSE 'Programada'
        END AS estado_cita
        
    FROM cita c
    INNER JOIN mascota m ON c.mascota_id = m.id
    INNER JOIN especie e ON m.especie_id = e.id
    INNER JOIN raza r ON m.raza_id = r.id
    INNER JOIN propietario p ON m.propietario_id = p.id
    INNER JOIN servicio s ON c.servicio_id = s.id
    WHERE c.veterinario_id = veterinario_id 
    AND c.fecha = fecha_consulta
    ORDER BY c.hora ASC;

    -- Resumen del día
    SELECT 
        COUNT(*) AS total_citas_dia,
        SUM(s.precio) AS ingresos_estimados_dia,
        AVG(s.precio) AS promedio_por_cita,
        MIN(c.hora) AS primera_cita,
        MAX(c.hora) AS ultima_cita,
        
        -- Distribución por tipo de servicio
        COUNT(CASE WHEN s.nombre LIKE '%Urgencia%' THEN 1 END) AS citas_urgencia,
        COUNT(CASE WHEN s.nombre LIKE '%Cirugia%' THEN 1 END) AS citas_cirugia,
        COUNT(CASE WHEN s.nombre LIKE '%Consulta%' THEN 1 END) AS citas_consulta,
        COUNT(CASE WHEN s.nombre NOT LIKE '%Urgencia%' AND s.nombre NOT LIKE '%Cirugia%' AND s.nombre NOT LIKE '%Consulta%' THEN 1 END) AS otros_servicios
        
    FROM cita c
    INNER JOIN servicio s ON c.servicio_id = s.id
    WHERE c.veterinario_id = veterinario_id 
    AND c.fecha = fecha_consulta;
END//
DELIMITER ;

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

-- ========================================
-- FIN DE VISTAS, FUNCIONES Y OBJETOS AVANZADOS
-- ========================================

-- Comentarios de uso:
-- Para usar las vistas: SELECT * FROM vw_estadisticas_vacunacion;
-- Para usar las funciones: SELECT fn_calcular_edad_mascota(1);
-- Para usar los SP: CALL sp_historial_completo_mascota(1);
-- Los triggers se ejecutan automáticamente con las operaciones INSERT/UPDATE