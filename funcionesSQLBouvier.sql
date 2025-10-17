USE VeterinariaBouvier;

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
-- FIN DE FUNCIONES
-- ========================================

-- Comentarios de uso:
-- Para usar las funciones: SELECT fn_calcular_edad_mascota(1);
-- SELECT fn_costo_total_mascota_año(1, 2024);