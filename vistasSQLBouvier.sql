USE VeterinariaBouvier;

-- ========================================
-- VISTAS (3 vistas)
-- ========================================

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

-- Vista 4: Control de Stock de Inventario
CREATE OR REPLACE VIEW vw_control_stock_inventario AS
SELECT 
    i.id AS inventario_id,
    i.nombre_producto,
    i.categoria,
    i.stock_actual,
    i.stock_minimo,
    i.precio_unitario,
    i.fecha_vencimiento,
    p.nombre_empresa AS proveedor,
    p.telefono AS telefono_proveedor,
    p.email AS email_proveedor,
    
    -- Alertas de stock
    CASE 
        WHEN i.stock_actual = 0 THEN 'SIN STOCK'
        WHEN i.stock_actual <= i.stock_minimo THEN 'STOCK BAJO'
        WHEN i.stock_actual <= (i.stock_minimo * 1.5) THEN 'STOCK LIMITADO'
        ELSE 'STOCK OK'
    END AS estado_stock,
    
    -- Alertas de vencimiento
    CASE 
        WHEN i.fecha_vencimiento <= CURDATE() THEN 'VENCIDO'
        WHEN i.fecha_vencimiento <= DATE_ADD(CURDATE(), INTERVAL 30 DAY) THEN 'VENCE EN 30 DÍAS'
        WHEN i.fecha_vencimiento <= DATE_ADD(CURDATE(), INTERVAL 90 DAY) THEN 'VENCE EN 90 DÍAS'
        ELSE 'VIGENTE'
    END AS estado_vencimiento,
    
    -- Cálculos financieros
    (i.stock_actual * i.precio_unitario) AS valor_stock_actual,
    ((i.stock_minimo - i.stock_actual) * i.precio_unitario) AS costo_reposicion_sugerida,
    
    -- Días para vencimiento
    DATEDIFF(i.fecha_vencimiento, CURDATE()) AS dias_para_vencer,
    
    -- Prioridad de compra
    CASE 
        WHEN i.stock_actual = 0 THEN 'URGENTE'
        WHEN i.stock_actual <= i.stock_minimo AND DATEDIFF(i.fecha_vencimiento, CURDATE()) <= 30 THEN 'URGENTE'
        WHEN i.stock_actual <= i.stock_minimo THEN 'ALTA'
        WHEN DATEDIFF(i.fecha_vencimiento, CURDATE()) <= 30 THEN 'MEDIA'
        ELSE 'BAJA'
    END AS prioridad_compra

FROM inventario i
INNER JOIN proveedor p ON i.proveedor_id = p.id
ORDER BY 
    CASE 
        WHEN i.stock_actual = 0 THEN 1
        WHEN i.stock_actual <= i.stock_minimo THEN 2
        WHEN DATEDIFF(i.fecha_vencimiento, CURDATE()) <= 30 THEN 3
        ELSE 4
    END,
    i.fecha_vencimiento ASC,
    i.stock_actual ASC;

-- Vista 5: Ranking de Veterinarios por Productividad
CREATE OR REPLACE VIEW vw_ranking_veterinarios_productividad AS
SELECT 
    v.id AS veterinario_id,
    CONCAT(v.nombre, ' ', v.apellido) AS veterinario_completo,
    v.matricula,
    v.telefono,
    v.email,
    
    -- Estadísticas de citas
    COUNT(c.id) AS total_citas_atendidas,
    COUNT(CASE WHEN YEAR(c.fecha) = YEAR(CURDATE()) THEN 1 END) AS citas_año_actual,
    COUNT(CASE WHEN YEAR(c.fecha) = YEAR(CURDATE()) AND MONTH(c.fecha) = MONTH(CURDATE()) THEN 1 END) AS citas_mes_actual,
    
    -- Ingresos generados
    COALESCE(SUM(s.precio), 0) AS ingresos_totales,
    COALESCE(SUM(CASE WHEN YEAR(c.fecha) = YEAR(CURDATE()) THEN s.precio ELSE 0 END), 0) AS ingresos_año_actual,
    COALESCE(SUM(CASE WHEN YEAR(c.fecha) = YEAR(CURDATE()) AND MONTH(c.fecha) = MONTH(CURDATE()) THEN s.precio ELSE 0 END), 0) AS ingresos_mes_actual,
    
    -- Promedios
    ROUND(COALESCE(AVG(s.precio), 0), 2) AS promedio_por_cita,
    ROUND(
        COALESCE(SUM(CASE WHEN YEAR(c.fecha) = YEAR(CURDATE()) AND MONTH(c.fecha) = MONTH(CURDATE()) THEN s.precio ELSE 0 END), 0) / 
        NULLIF(COUNT(CASE WHEN YEAR(c.fecha) = YEAR(CURDATE()) AND MONTH(c.fecha) = MONTH(CURDATE()) THEN 1 END), 0), 2
    ) AS promedio_mes_actual,
    
    -- Distribución de servicios
    COUNT(CASE WHEN s.nombre LIKE '%Urgencia%' THEN 1 END) AS total_urgencias,
    COUNT(CASE WHEN s.nombre LIKE '%Cirugia%' THEN 1 END) AS total_cirugias,
    COUNT(CASE WHEN s.nombre LIKE '%Consulta%' THEN 1 END) AS total_consultas,
    COUNT(CASE WHEN s.nombre LIKE '%Tratamiento%' THEN 1 END) AS total_tratamientos,
    
    -- Porcentajes de especialización
    CONCAT(
        ROUND(
            (COUNT(CASE WHEN s.nombre LIKE '%Cirugia%' THEN 1 END) * 100.0) / 
            NULLIF(COUNT(c.id), 0), 2
        ), '%'
    ) AS porcentaje_cirugias,
    CONCAT(
        ROUND(
            (COUNT(CASE WHEN s.nombre LIKE '%Urgencia%' THEN 1 END) * 100.0) / 
            NULLIF(COUNT(c.id), 0), 2
        ), '%'
    ) AS porcentaje_urgencias,
    
    -- Actividad reciente (últimos 30 días)
    COUNT(CASE WHEN c.fecha >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) THEN 1 END) AS citas_ultimos_30_dias,
    COALESCE(SUM(CASE WHEN c.fecha >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) THEN s.precio ELSE 0 END), 0) AS ingresos_ultimos_30_dias,
    
    -- Ranking interno
    RANK() OVER (ORDER BY COALESCE(SUM(CASE WHEN YEAR(c.fecha) = YEAR(CURDATE()) THEN s.precio ELSE 0 END), 0) DESC) AS ranking_ingresos,
    RANK() OVER (ORDER BY COUNT(CASE WHEN YEAR(c.fecha) = YEAR(CURDATE()) THEN 1 END) DESC) AS ranking_citas

FROM veterinario v
LEFT JOIN cita c ON v.id = c.veterinario_id
LEFT JOIN servicio s ON c.servicio_id = s.id
GROUP BY 
    v.id,
    v.nombre,
    v.apellido,
    v.matricula,
    v.telefono,
    v.email
ORDER BY 
    ingresos_año_actual DESC,
    citas_año_actual DESC,
    promedio_por_cita DESC;

-- Vista 6: Dashboard Financiero Integral
CREATE OR REPLACE VIEW vw_dashboard_financiero_integral AS
SELECT 
    p.id AS propietario_id,
    CONCAT(p.nombre, ' ', p.apellido) AS cliente_completo,
    p.telefono,
    p.email,
    p.direccion,
    
    -- Conteo de mascotas
    COUNT(DISTINCT m.id) AS total_mascotas,
    
    -- Análisis de facturación
    COUNT(DISTINCT f.id) AS total_facturas,
    COALESCE(SUM(f.total), 0) AS total_facturado,
    COALESCE(SUM(CASE WHEN f.estado_pago = 'PAGADO' THEN f.total ELSE 0 END), 0) AS total_cobrado,
    COALESCE(SUM(CASE WHEN f.estado_pago = 'PENDIENTE' THEN f.total ELSE 0 END), 0) AS total_por_cobrar,
    COALESCE(SUM(CASE WHEN f.estado_pago = 'VENCIDO' THEN f.total ELSE 0 END), 0) AS total_vencido,
    
    -- Análisis temporal
    COALESCE(SUM(CASE WHEN YEAR(f.fecha_factura) = YEAR(CURDATE()) THEN f.total ELSE 0 END), 0) AS facturado_año_actual,
    COALESCE(SUM(CASE WHEN YEAR(f.fecha_factura) = YEAR(CURDATE()) AND MONTH(f.fecha_factura) = MONTH(CURDATE()) THEN f.total ELSE 0 END), 0) AS facturado_mes_actual,
    
    -- Servicios más utilizados
    COUNT(CASE WHEN s.nombre LIKE '%Consulta%' THEN 1 END) AS servicios_consulta,
    COUNT(CASE WHEN s.nombre LIKE '%Urgencia%' THEN 1 END) AS servicios_urgencia,
    COUNT(CASE WHEN s.nombre LIKE '%Cirugia%' THEN 1 END) AS servicios_cirugia,
    COUNT(CASE WHEN s.nombre LIKE '%Tratamiento%' THEN 1 END) AS servicios_tratamiento,
    
    -- Análisis de rentabilidad
    ROUND(COALESCE(AVG(f.total), 0), 2) AS ticket_promedio,
    COALESCE(SUM(f.total), 0) / NULLIF(COUNT(DISTINCT m.id), 0) AS gasto_promedio_por_mascota,
    
    -- Frecuencia de visitas
    COUNT(c.id) AS total_citas_historicas,
    COUNT(CASE WHEN c.fecha >= DATE_SUB(CURDATE(), INTERVAL 365 DAY) THEN 1 END) AS citas_ultimo_año,
    COUNT(CASE WHEN c.fecha >= DATE_SUB(CURDATE(), INTERVAL 90 DAY) THEN 1 END) AS citas_ultimos_90_dias,
    
    -- Clasificación de cliente
    CASE 
        WHEN COALESCE(SUM(CASE WHEN YEAR(f.fecha_factura) = YEAR(CURDATE()) THEN f.total ELSE 0 END), 0) >= 50000 THEN 'PREMIUM'
        WHEN COALESCE(SUM(CASE WHEN YEAR(f.fecha_factura) = YEAR(CURDATE()) THEN f.total ELSE 0 END), 0) >= 20000 THEN 'VIP'
        WHEN COALESCE(SUM(CASE WHEN YEAR(f.fecha_factura) = YEAR(CURDATE()) THEN f.total ELSE 0 END), 0) >= 5000 THEN 'REGULAR'
        WHEN COALESCE(SUM(CASE WHEN YEAR(f.fecha_factura) = YEAR(CURDATE()) THEN f.total ELSE 0 END), 0) > 0 THEN 'BÁSICO'
        ELSE 'INACTIVO'
    END AS categoria_cliente,
    
    -- Estado financiero
    CASE 
        WHEN COALESCE(SUM(CASE WHEN f.estado_pago = 'VENCIDO' THEN f.total ELSE 0 END), 0) > 0 THEN 'CON DEUDA VENCIDA'
        WHEN COALESCE(SUM(CASE WHEN f.estado_pago = 'PENDIENTE' THEN f.total ELSE 0 END), 0) > 0 THEN 'CON DEUDA PENDIENTE'
        ELSE 'AL DÍA'
    END AS estado_financiero,
    
    -- Última actividad
    MAX(c.fecha) AS ultima_cita,
    MAX(f.fecha_factura) AS ultima_factura,
    DATEDIFF(CURDATE(), MAX(c.fecha)) AS dias_sin_actividad

FROM propietario p
LEFT JOIN mascota m ON p.id = m.propietario_id
LEFT JOIN cita c ON m.id = c.mascota_id
LEFT JOIN servicio s ON c.servicio_id = s.id
LEFT JOIN facturacion f ON p.id = f.propietario_id
GROUP BY 
    p.id,
    p.nombre,
    p.apellido,
    p.telefono,
    p.email,
    p.direccion
HAVING COUNT(DISTINCT m.id) > 0  -- Solo clientes con mascotas
ORDER BY 
    total_facturado DESC,
    total_por_cobrar DESC,
    categoria_cliente,
    ultima_cita DESC;

-- ========================================
-- FIN DE VISTAS
-- ========================================

-- Comentarios de uso:
-- VISTAS ORIGINALES:
-- SELECT * FROM vw_estadisticas_vacunacion;
-- SELECT * FROM vw_ingresos_mensuales_tratamientos;
-- SELECT * FROM vw_mascotas_por_zona_montevideo;
--
-- VISTAS NUEVAS:
-- SELECT * FROM vw_control_stock_inventario WHERE estado_stock = 'STOCK BAJO';
-- SELECT * FROM vw_ranking_veterinarios_productividad ORDER BY ranking_ingresos;
-- SELECT * FROM vw_dashboard_financiero_integral WHERE categoria_cliente IN ('PREMIUM', 'VIP');