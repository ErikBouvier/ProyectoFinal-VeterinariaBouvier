USE VeterinariaBouvier;

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
-- FIN DE STORED PROCEDURES
-- ========================================

-- Comentarios de uso:
-- Para usar los SP: CALL sp_historial_completo_mascota(1);
-- CALL sp_agenda_diaria_veterinario(1, '2024-10-15');