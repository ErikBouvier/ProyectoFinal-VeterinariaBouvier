USE VeterinariaBouvier;

-- ========================================
-- INSERCIÓN DE DATOS
-- ========================================

-- Tabla: propietario (20 registros)
INSERT INTO propietario (nombre, apellido, telefono, email, direccion) VALUES
('María', 'González', '2708-3456', 'maria.gonzalez@hotmail.com', 'Rivera 1234, Pocitos'),
('Carlos', 'Rodríguez', '2901-5678', 'crodriguez78@gmail.com', 'Bulevar Artigas 567, Punta Carretas'),
('Ana', 'Martínez', '2403-9876', 'anamartinez@gmail.com', 'Luis Alberto de Herrera 890, Tres Cruces'),
('Roberto', 'Silva', '2605-1234', 'rob.silva@outlook.com', 'Av. Italia 2341, Malvín'),
('Lucía', 'Fernández', '2502-7890', 'luciafernandez@gmail.com', '18 de Julio 1567, Centro'),
('Diego', 'López', '2709-4321', 'diegolopez85@hotmail.com', 'Rambla República del Perú 445, Pocitos'),
('Patricia', 'Morales', '2408-6543', 'pmorales@gmail.com', 'Av. Brasil 2678, La Blanqueada'),
('Alejandro', 'Castro', '2601-2468', 'alecastro@adinet.com.uy', 'Millán 1234, Reducto'),
('Claudia', 'Herrera', '2507-8642', 'claudiaherrera@outlook.com', 'Bvar. España 1890, Parque Rodó'),
('Fernando', 'Jiménez', '2904-1357', 'ferjimenez@gmail.com', 'Ellauri 567, Punta Carretas'),
('Silvia', 'Romero', '2402-9753', 'silviaromero@hotmail.com', 'Constituyente 1123, Centro'),
('Gustavo', 'Vargas', '2708-2468', 'gustavovargas@gmail.com', 'Av. Rivera 2445, Carrasco'),
('Mónica', 'Peña', '2506-8147', 'monicapena@adinet.com.uy', 'Joaquín Requena 678, Cordón'),
('Ramón', 'Aguilar', '2901-3692', 'ramonaguilar@outlook.com', 'Av. 8 de Octubre 1456, Tres Cruces'),
('Teresa', 'Mendoza', '2403-7418', 'teremendoza@gmail.com', 'Rondeau 789, Barrio Sur'),
('Sergio', 'Ortega', '2605-9630', 'sergioortega@hotmail.com', 'Dr. Luis Morquio 234, Villa Dolores'),
('Valeria', 'Ramos', '2709-5174', 'valeriaramos@gmail.com', 'Gabriel Pereira 567, Aguada'),
('Jorge', 'Delgado', '2407-8259', 'jorgedelgado@adinet.com.uy', 'Canelones 890, Centro'),
('Cristina', 'Vega', '2502-6384', 'cristinavega@outlook.com', 'Av. Agraciada 1234, Atahualpa'),
('Pablo', 'Santana', '2608-4927', 'pablosantana@gmail.com', 'Scoseria 445, Malvín Norte');

-- Tabla: especie (3 registros)
INSERT INTO especie (nombre) VALUES
('Canino'),
('Felino'),
('Otras');

-- Tabla: veterinario (10 registros)
INSERT INTO veterinario (nombre, apellido, matricula, telefono, email) VALUES
-- Veterinarios de Clínica General
('Andrea', 'Pérez', 'VET-001-CG', '2708-5555', 'aperez@veterinariabouvier.com.uy'),
('Martín', 'García', 'VET-002-CG', '2901-6666', 'mgarcia@veterinariabouvier.com.uy'),
('Carolina', 'López', 'VET-003-CG', '2403-7777', 'clopez@veterinariabouvier.com.uy'),
('Ricardo', 'Sánchez', 'VET-004-CG', '2605-8888', 'rsanchez@veterinariabouvier.com.uy'),
('Gabriela', 'Martín', 'VET-005-CG', '2502-9999', 'gmartin@veterinariabouvier.com.uy'),
-- Veterinarios Especialistas
('Dr. Eduardo', 'Rossi', 'VET-006-CIR', '2709-1111', 'erossi.cirujano@veterinariabouvier.com.uy'),
('Dra. Valeria', 'Torres', 'VET-007-TRA', '2408-2222', 'vtorres.traumatologo@veterinariabouvier.com.uy'),
('Dr. Sebastián', 'Mendez', 'VET-008-INT', '2601-3333', 'smendez.internista@veterinariabouvier.com.uy'),
('Dra. Florencia', 'Costa', 'VET-009-OFT', '2507-4444', 'fcosta.oftalmologo@veterinariabouvier.com.uy'),
('Dr. Alejandro', 'Vidal', 'VET-010-IMG', '2904-5555', 'avidal.imagenologo@veterinariabouvier.com.uy');

-- Tabla: servicio (13 registros - ordenados por importancia)
INSERT INTO servicio (nombre, descripcion, precio) VALUES
-- Servicios médicos críticos
('Urgencia', 'Atención veterinaria de emergencia 24 horas', 2500.00),
('Cirugia', 'Procedimientos quirúrgicos especializados', 8000.00),
('Internacion', 'Hospitalización y cuidados intensivos', 1800.00),
('Tratamiento', 'Tratamientos médicos ambulatorios', 1200.00),
-- Servicios diagnósticos
('Laboratorio', 'Análisis clínicos y estudios de laboratorio', 900.00),
('Ecografia', 'Estudios ecográficos diagnósticos', 1500.00),
('Radiografia', 'Estudios radiológicos', 1200.00),
('Electrocardiografia', 'Estudios cardiológicos especializados', 1000.00),
-- Servicios especializados
('Consulta_especialista', 'Consulta con veterinario especialista', 1800.00),
('Inyectable', 'Aplicación de medicamentos inyectables', 400.00),
-- Servicios complementarios
('Traslado', 'Servicio de traslado de mascotas', 600.00),
('Pensionado', 'Servicio de pensión y cuidado temporal', 800.00),
('Peluqueria', 'Servicios de estética y peluquería canina', 500.00);

-- Tabla: vacuna (9 registros)
INSERT INTO vacuna (nombre, descripcion) VALUES
-- Vacunas Caninas
('1era dosis canino', 'Primera dosis del plan de vacunación canino básico'),
('2da dosis canino', 'Segunda dosis del plan de vacunación canino básico'), 
('3era dosis canino', 'Tercera dosis del plan de vacunación canino básico'),
('Hexadog', 'Vacuna séxtuple canina - protección completa'),
('Vacuna KC intra nasal', 'Vacuna contra tos de las perreras - aplicación intranasal'),
-- Vacunas Felinas
('1era dosis felino', 'Primera dosis del plan de vacunación felino básico'),
('2da dosis felino', 'Segunda dosis del plan de vacunación felino básico'),
('Vacuna VILEF', 'Vacuna contra virus de leucemia felina'),
('Vacuna INFERVAC', 'Vacuna felina contra infecciones respiratorias');

-- Tabla: raza (22 registros - razas populares de Uruguay en orden alfabético)
INSERT INTO raza (especie_id, nombre) VALUES
-- Razas Caninas (especie_id = 1)
(1, 'Beagle'),
(1, 'Border Collie'),
(1, 'Boxer'),
(1, 'Bulldog Francés'),
(1, 'Caniche'),
(1, 'Cocker Spaniel'),
(1, 'Dálmata'),
(1, 'Dogo Argentino'),
(1, 'Golden Retriever'),
(1, 'Labrador'),
(1, 'Mestizo'),
(1, 'Ovejero Alemán'),
(1, 'Pastor Belga'),
(1, 'Pitbull'),
(1, 'Rottweiler'),
(1, 'Schnauzer'),
-- Razas Felinas (especie_id = 2)
(2, 'Angora'),
(2, 'Mestizo'),
(2, 'Persa'),
(2, 'Siamés'),
-- Otras especies (especie_id = 3)
(3, 'Conejo Común'),
(3, 'Otros');

-- Tabla: mascota (25 registros)
INSERT INTO mascota (nombre, fecha_nacimiento, peso, especie_id, raza_id, propietario_id) VALUES
-- Mascotas Caninas
('Max', '2022-03-15', 28.50, 1, 10, 1),        -- Labrador de María González
('Luna', '2021-08-22', 12.30, 1, 5, 2),        -- Caniche de Carlos Rodríguez
('Rocky', '2020-11-10', 35.20, 1, 3, 3),       -- Boxer de Ana Martínez
('Bella', '2023-01-05', 25.80, 1, 9, 4),       -- Golden Retriever de Roberto Silva
('Toby', '2022-07-18', 8.90, 1, 4, 5),         -- Bulldog Francés de Lucía Fernández
('Lola', '2021-12-03', 15.40, 1, 6, 6),        -- Cocker Spaniel de Diego López
('Bruno', '2020-05-28', 42.10, 1, 12, 7),      -- Ovejero Alemán de Patricia Morales
('Coco', '2023-04-12', 22.70, 1, 7, 8),        -- Dálmata de Alejandro Castro
('Mía', '2022-09-14', 18.60, 1, 1, 9),         -- Beagle de Claudia Herrera
('Zeus', '2021-06-07', 38.90, 1, 15, 10),      -- Rottweiler de Fernando Jiménez
('Nina', '2023-02-20', 31.20, 1, 8, 11),       -- Dogo Argentino de Silvia Romero
('Thor', '2020-10-16', 16.80, 1, 16, 12),      -- Schnauzer de Gustavo Vargas
('Kiara', '2022-12-08', 20.40, 1, 2, 13),      -- Border Collie de Mónica Peña
('Simba', '2021-04-25', 29.10, 1, 14, 14),     -- Pitbull de Ramón Aguilar
('Dora', '2023-06-30', 24.50, 1, 13, 15),      -- Pastor Belga de Teresa Mendoza
-- Mascotas Felinas
('Mimi', '2022-02-14', 4.20, 2, 17, 16),       -- Angora de Sergio Ortega
('Garfield', '2021-09-11', 5.80, 2, 19, 17),   -- Persa de Valeria Ramos
('Salem', '2023-03-07', 3.90, 2, 20, 18),      -- Siamés de Jorge Delgado
('Pelusa', '2022-11-19', 4.60, 2, 17, 19),     -- Angora de Cristina Vega
('Felix', '2020-12-23', 5.20, 2, 19, 20),      -- Persa de Pablo Santana
-- Otras mascotas
('Bugs', '2022-05-10', 2.10, 3, 21, 1),        -- Conejo de María González
('Pepe', '2021-07-15', 6.40, 1, 11, 3),        -- Mestizo Canino de Ana Martínez
('Nemo', '2023-01-28', 4.80, 2, 18, 5),        -- Mestizo Felino de Lucía Fernández
('Chispa', '2022-08-03', 7.20, 1, 11, 8),      -- Mestizo Canino de Alejandro Castro
('Copito', '2021-11-12', 1.80, 3, 21, 12);     -- Conejo de Gustavo Vargas

-- Tabla: cita (15 registros)
INSERT INTO cita (veterinario_id, mascota_id, fecha, hora, servicio_id, observaciones) VALUES
-- Citas de emergencia y cirugías
(6, 1, '2024-09-15', '09:00:00', 2, 'Cirugía programada - extracción de tumor'),
(1, 5, '2024-09-20', '14:30:00', 1, 'Urgencia - dificultad respiratoria'),
(7, 10, '2024-09-22', '10:15:00', 3, 'Internación post-cirugía - observación 24hs'),
-- Consultas especializadas
(9, 3, '2024-09-25', '11:00:00', 9, 'Consulta oftalmológica - revisión de cataratas'),
(8, 15, '2024-09-26', '15:45:00', 9, 'Consulta internista - problemas digestivos'),
(10, 7, '2024-09-28', '08:30:00', 6, 'Ecografía abdominal de control'),
-- Estudios diagnósticos
(2, 12, '2024-10-01', '16:00:00', 5, 'Análisis de sangre - chequeo anual'),
(4, 18, '2024-10-02', '09:45:00', 7, 'Radiografía de cadera'),
(3, 20, '2024-10-03', '13:20:00', 8, 'Electrocardiograma - soplo cardíaco'),
-- Tratamientos y servicios generales
(5, 8, '2024-10-05', '10:30:00', 4, 'Tratamiento dermatológico - alergia'),
(1, 14, '2024-10-07', '14:00:00', 10, 'Aplicación de vacuna antirrábica'),
(2, 22, '2024-10-08', '11:15:00', 4, 'Control post-tratamiento - infección urinaria'),
-- Servicios complementarios
(3, 6, '2024-10-10', '16:30:00', 13, 'Peluquería y corte de uñas'),
(4, 11, '2024-10-12', '12:00:00', 11, 'Traslado para cirugía especializada'),
(5, 25, '2024-10-15', '08:45:00', 12, 'Pensionado por viaje del propietario');

-- Tabla: historial_medico (50 registros)
INSERT INTO historial_medico (veterinario_id, mascota_id, fecha, descripcion) VALUES
-- Historiales de Max (Labrador)
(1, 1, '2022-04-10', 'Primera consulta - cachorro de 4 semanas. Peso: 3.2kg. Estado general bueno'),
(1, 1, '2022-06-15', 'Control mensual - crecimiento normal. Peso: 8.5kg. Plan de vacunación al día'),
(2, 1, '2023-01-20', 'Consulta por vómitos. Diagnóstico: gastroenteritis leve. Tratamiento sintomático'),
(6, 1, '2024-09-15', 'Cirugía exitosa - extracción de tumor benigno en pata trasera. Sin complicaciones'),
(1, 1, '2024-09-25', 'Control post-cirugía. Cicatrización correcta. Alta médica'),

-- Historiales de Luna (Caniche)
(2, 2, '2021-09-05', 'Primera consulta - cachorra de 6 semanas. Examen físico normal'),
(3, 2, '2022-03-12', 'Consulta dermatológica - dermatitis alérgica. Tratamiento con antihistamínicos'),
(2, 2, '2023-08-18', 'Control anual. Estado general excelente. Peso ideal: 12.3kg'),
(4, 2, '2024-05-20', 'Limpieza dental. Extracción de 2 piezas dentales. Recuperación satisfactoria'),

-- Historiales de Rocky (Boxer)
(9, 3, '2020-12-15', 'Primera consulta - cachorro de 8 semanas. Plan de vacunación iniciado'),
(9, 3, '2021-05-10', 'Consulta oftalmológica - detección temprana de cataratas juveniles'),
(1, 3, '2022-11-22', 'Control de rutina. Cataratas estables. Recomendación de control semestral'),
(9, 3, '2024-09-25', 'Evaluación oftalmológica - cataratas en progresión lenta. Sin cirugía por ahora'),

-- Historiales de Bella (Golden Retriever)
(4, 4, '2023-02-01', 'Primera consulta - cachorra de 3 semanas. Peso bajo: 1.8kg'),
(1, 4, '2023-04-15', 'Control de crecimiento. Peso normalizado: 15.2kg. Desarrollo adecuado'),
(5, 4, '2024-07-08', 'Consulta por cojera leve. Radiografía normal. Reposo relativo'),

-- Historiales de Toby (Bulldog Francés)
(2, 5, '2022-08-20', 'Primera consulta - cachorro de 6 semanas. Síndrome braquicefálico leve'),
(1, 5, '2024-09-20', 'Urgencia - crisis respiratoria. Estabilizado con oxigenoterapia. Alta al día siguiente'),
(8, 5, '2024-09-22', 'Consulta internista - evaluación cardiopulmonar post-crisis. Medicación preventiva'),

-- Historiales de Lola (Cocker Spaniel)
(3, 6, '2022-01-10', 'Primera consulta - cachorra de 4 semanas. Examen físico normal'),
(5, 6, '2023-06-18', 'Consulta por otitis externa. Tratamiento tópico exitoso'),
(3, 6, '2024-10-10', 'Control rutinario + peluquería. Estado general excelente'),

-- Historiales de Bruno (Ovejero Alemán)
(4, 7, '2020-06-25', 'Primera consulta - cachorro de 5 semanas. Plan de vacunación completo'),
(7, 7, '2022-08-14', 'Consulta traumatológica - displasia leve de cadera. Tratamiento conservador'),
(10, 7, '2024-09-28', 'Ecografía abdominal de control. Sin hallazgos patológicos'),
(4, 7, '2024-10-05', 'Control ortopédico - displasia estable. Continuar con ejercicio moderado'),

-- Historiales de Coco (Dálmata)
(5, 8, '2023-05-15', 'Primera consulta - cachorro de 7 semanas. Examen físico normal'),
(5, 8, '2024-10-05', 'Consulta dermatológica - alergia alimentaria. Dieta hipoalergénica'),
(1, 8, '2024-10-12', 'Control post-tratamiento. Mejoría notable en lesiones cutáneas'),

-- Historiales de Mía (Beagle)
(1, 9, '2022-10-20', 'Primera consulta - cachorra de 6 semanas. Peso: 2.1kg'),
(2, 9, '2023-07-25', 'Control anual. Sobrepeso leve. Plan nutricional ajustado'),
(1, 9, '2024-06-30', 'Control de peso. Reducción exitosa a 18.6kg. Felicitaciones al propietario'),

-- Historiales de Zeus (Rottweiler)
(7, 10, '2021-07-15', 'Primera consulta - cachorro de 8 semanas. Desarrollo normal'),
(6, 10, '2024-09-20', 'Pre-quirúrgico - análisis completos normales. Apto para cirugía'),
(7, 10, '2024-09-22', 'Post-operatorio - evolución favorable. Internación de 24hs'),
(6, 10, '2024-10-01', 'Control post-cirugía. Cicatrización perfecta. Alta definitiva'),

-- Historiales de Nina (Dogo Argentino)
(8, 11, '2023-03-10', 'Primera consulta - cachorra de 4 semanas. Examen físico completo normal'),
(4, 11, '2024-10-12', 'Preparación para traslado a centro especializado. Documentación completa'),

-- Historiales de Thor (Schnauzer)
(2, 12, '2020-11-20', 'Primera consulta - cachorro de 6 semanas. Plan preventivo iniciado'),
(2, 12, '2024-10-01', 'Análisis de sangre anual. Todos los parámetros dentro de rangos normales'),
(1, 12, '2024-10-08', 'Control geriátrico. Recomendaciones para cuidados en edad avanzada'),

-- Historiales de Kiara (Border Collie)
(3, 13, '2023-01-15', 'Primera consulta - cachorra de 5 semanas. Desarrollo psicomotor excelente'),
(1, 13, '2024-08-20', 'Control de comportamiento. Recomendaciones de entrenamiento y socialización'),

-- Historiales de Simba (Pitbull)
(4, 14, '2021-05-30', 'Primera consulta - cachorro de 7 semanas. Examen físico normal'),
(1, 14, '2024-10-07', 'Aplicación de vacuna antirrábica anual. Estado general excelente'),

-- Historiales de Dora (Pastor Belga)
(8, 15, '2023-07-15', 'Primera consulta - cachorra de 6 semanas. Peso: 3.8kg'),
(8, 15, '2024-09-26', 'Consulta internista - problemas digestivos crónicos. Dieta especial'),
(8, 15, '2024-10-10', 'Control post-tratamiento. Mejoría significativa en síntomas digestivos'),

-- Historiales de Mimi (Angora)
(5, 16, '2022-03-20', 'Primera consulta - gatita de 8 semanas. Plan de vacunación felina'),
(3, 16, '2023-09-12', 'Control anual. Estado general bueno. Peso ideal para la raza'),

-- Historiales de Garfield (Persa)
(4, 17, '2021-10-18', 'Primera consulta - gatito de 10 semanas. Examen físico normal'),
(2, 17, '2023-05-14', 'Consulta dermatológica - dermatitis por pulgas. Tratamiento antipulgas'),
(4, 17, '2024-08-25', 'Control rutinario. Cepillado frecuente recomendado por tipo de pelo'),

-- Historiales de Salem (Siamés)
(4, 18, '2023-04-10', 'Primera consulta - gatito de 6 semanas. Desarrollo normal'),
(4, 18, '2024-10-02', 'Radiografía de cadera - descarte de displasia. Resultado normal'),

-- Historiales de Pelusa (Angora)
(3, 19, '2023-01-05', 'Primera consulta - gatita de 7 semanas. Examen físico completo'),
(5, 19, '2024-07-18', 'Control anual. Recomendaciones de cuidado del pelaje largo'),

-- Historiales de Felix (Persa)
(2, 20, '2021-01-15', 'Primera consulta - gatito de 8 semanas. Plan preventivo iniciado'),
(3, 20, '2024-10-03', 'Electrocardiograma - evaluación de soplo cardíaco detectado. Soplo funcional'),
(8, 20, '2024-10-15', 'Consulta cardiológica - soplo benigno. Control anual recomendado');

-- Tabla: vacuna_aplicada (40 registros - considerando edades de mascotas)
INSERT INTO vacuna_aplicada (veterinario_id, mascota_id, vacuna_id, fecha_aplicacion, observaciones) VALUES
-- Vacunación de Max (Labrador - nacido 2022-03-15)
(1, 1, 1, '2022-05-15', 'Primera dosis - cachorro de 8 semanas'),
(1, 1, 2, '2022-06-15', 'Segunda dosis - cachorro de 12 semanas'),
(1, 1, 3, '2022-07-15', 'Tercera dosis - cachorro de 16 semanas'),
(2, 1, 4, '2023-03-15', 'Hexadog - refuerzo anual'),
(1, 1, 4, '2024-03-15', 'Hexadog - refuerzo anual'),

-- Vacunación de Luna (Caniche - nacido 2021-08-22)
(2, 2, 1, '2021-10-22', 'Primera dosis - cachorro de 8 semanas'),
(2, 2, 2, '2021-11-22', 'Segunda dosis - cachorro de 12 semanas'),
(3, 2, 3, '2021-12-22', 'Tercera dosis - cachorro de 16 semanas'),
(2, 2, 4, '2022-08-22', 'Hexadog - refuerzo anual'),
(3, 2, 4, '2023-08-22', 'Hexadog - refuerzo anual'),
(2, 2, 4, '2024-08-22', 'Hexadog - refuerzo anual'),

-- Vacunación de Rocky (Boxer - nacido 2020-11-10)
(1, 3, 4, '2021-11-10', 'Hexadog - refuerzo anual'),
(4, 3, 4, '2022-11-10', 'Hexadog - refuerzo anual'),
(1, 3, 4, '2023-11-10', 'Hexadog - refuerzo anual'),
(3, 3, 5, '2024-05-15', 'KC intranasal - prevención tos de perreras'),

-- Vacunación de Bella (Golden - nacido 2023-01-05)
(4, 4, 1, '2023-03-05', 'Primera dosis - cachorro de 8 semanas'),
(1, 4, 2, '2023-04-05', 'Segunda dosis - cachorro de 12 semanas'),
(4, 4, 3, '2023-05-05', 'Tercera dosis - cachorro de 16 semanas'),
(1, 4, 4, '2024-01-05', 'Hexadog - refuerzo anual'),

-- Vacunación de Toby (Bulldog Francés - nacido 2022-07-18)
(2, 5, 1, '2022-09-18', 'Primera dosis - cachorro de 8 semanas'),
(1, 5, 2, '2022-10-18', 'Segunda dosis - cachorro de 12 semanas'),
(2, 5, 3, '2022-11-18', 'Tercera dosis - cachorro de 16 semanas'),
(1, 5, 4, '2023-07-18', 'Hexadog - refuerzo anual'),
(2, 5, 4, '2024-07-18', 'Hexadog - refuerzo anual'),

-- Vacunación de Bruno (Ovejero Alemán - nacido 2020-05-28)
(4, 7, 4, '2021-05-28', 'Hexadog - refuerzo anual'),
(1, 7, 4, '2022-05-28', 'Hexadog - refuerzo anual'),
(4, 7, 4, '2023-05-28', 'Hexadog - refuerzo anual'),
(2, 7, 4, '2024-05-28', 'Hexadog - refuerzo anual'),

-- Vacunación de Mimi (Angora - nacido 2022-02-14)
(5, 16, 6, '2022-04-14', 'Primera dosis felino - cachorro de 8 semanas'),
(3, 16, 7, '2022-05-14', 'Segunda dosis felino - cachorro de 12 semanas'),
(5, 16, 8, '2022-06-14', 'VILEF - leucemia felina'),
(3, 16, 6, '2023-02-14', 'Primera dosis felino - refuerzo anual'),
(5, 16, 7, '2024-02-14', 'Segunda dosis felino - refuerzo anual'),

-- Vacunación de Garfield (Persa - nacido 2021-09-11)
(4, 17, 6, '2021-11-11', 'Primera dosis felino - cachorro de 8 semanas'),
(2, 17, 7, '2021-12-11', 'Segunda dosis felino - cachorro de 12 semanas'),
(4, 17, 9, '2022-01-11', 'INFERVAC - infecciones respiratorias'),
(2, 17, 6, '2022-09-11', 'Primera dosis felino - refuerzo anual'),
(4, 17, 7, '2023-09-11', 'Segunda dosis felino - refuerzo anual'),
(2, 17, 8, '2024-09-11', 'VILEF - refuerzo leucemia felina'),

-- Vacunación de Salem (Siamés - nacido 2023-03-07)
(4, 18, 6, '2023-05-07', 'Primera dosis felino - cachorro de 8 semanas'),
(3, 18, 7, '2023-06-07', 'Segunda dosis felino - cachorro de 12 semanas'),
(4, 18, 9, '2023-07-07', 'INFERVAC - infecciones respiratorias'),
(3, 18, 6, '2024-03-07', 'Primera dosis felino - refuerzo anual');

-- ========================================
-- INSERCIÓN DE DATOS - NUEVAS TABLAS
-- ========================================

-- Tabla: proveedor (10 registros)
INSERT INTO proveedor (nombre_empresa, contacto, telefono, email, direccion, rubro) VALUES
('VetSupply Uruguay S.A.', 'Ing. Roberto Méndez', '2712-3456', 'ventas@vetsupply.com.uy', 'Av. Italia 3245, Montevideo', 'Medicamentos Veterinarios'),
('Farmacias Veterinarias del Plata', 'Dra. Ana Vázquez', '2908-7654', 'pedidos@farmaplata.com.uy', 'Bvar. Batlle y Ordóñez 1890, Montevideo', 'Farmacia Veterinaria'),
('Instrumentos Médicos Uruguay', 'Téc. Carlos Fernández', '2405-2468', 'info@imuruguay.com', 'Mercedes 1567, Montevideo', 'Instrumental Médico'),
('Alimentos Premium Pet', 'Lic. María Rodriguez', '2609-8642', 'comercial@premiumpet.uy', 'Av. 8 de Octubre 2678, Montevideo', 'Alimentos y Suplementos'),
('Laboratorio Biovet', 'Dr. Alejandro Costa', '2503-1357', 'laboratorio@biovet.com.uy', 'Bvar. España 3456, Montevideo', 'Análisis Clínicos'),
('Distribuidora Médica del Sur', 'Sr. Fernando Silva', '2710-9753', 'ventas@medsur.uy', 'Av. Rivera 4567, Montevideo', 'Insumos Médicos'),
('Vacunas Internacionales Ltda.', 'Dra. Patricia Herrera', '2407-4816', 'internacional@vacunas.uy', 'Luis Alberto de Herrera 1234, Montevideo', 'Vacunas Importadas'),
('Quirófano Supply', 'Téc. Diego Martínez', '2604-7259', 'quirofano@supply.com.uy', 'Canelones 2890, Montevideo', 'Equipamiento Quirúrgico'),
('MegaPet Distribuidora', 'Lic. Claudia López', '2508-3614', 'megapet@distribuidora.uy', 'Av. Millán 3678, Montevideo', 'Productos Generales'),
('Importadora Vet-Tech', 'Ing. Gustavo Pereira', '2902-5927', 'importaciones@vettech.uy', 'Colonia 1567, Montevideo', 'Tecnología Veterinaria');

-- Tabla: inventario (25 registros)
INSERT INTO inventario (nombre_producto, categoria, stock_actual, stock_minimo, precio_unitario, fecha_vencimiento, proveedor_id) VALUES
-- Medicamentos
('Amoxicilina 250mg (100 comp)', 'Antibióticos', 45, 10, 890.00, '2025-08-15', 1),
('Meloxicam 15mg (30 comp)', 'Antiinflamatorios', 8, 15, 1200.00, '2025-06-20', 1),
('Prednisolona 5mg (50 comp)', 'Corticoides', 25, 8, 750.00, '2025-09-10', 2),
('Omeprazol 20mg (60 cáps)', 'Gastroprotectores', 12, 10, 980.00, '2025-07-30', 2),
('Furosemida 40mg (100 comp)', 'Diuréticos', 32, 12, 670.00, '2025-11-25', 1),
-- Vacunas
('Hexadog (frasco 10 dosis)', 'Vacunas', 6, 8, 2400.00, '2025-03-15', 7),
('Nobivac Felino (frasco 10 dosis)', 'Vacunas', 4, 6, 2100.00, '2025-04-20', 7),
('Vacuna Antirrábica (frasco 10 dosis)', 'Vacunas', 12, 10, 1800.00, '2025-05-30', 7),
('VILEF (frasco 5 dosis)', 'Vacunas', 3, 5, 2800.00, '2025-02-28', 7),
-- Insumos médicos
('Jeringas 3ml (caja 100 unid)', 'Insumos', 8, 20, 450.00, '2026-12-31', 6),
('Agujas 21G (caja 100 unid)', 'Insumos', 15, 25, 320.00, '2027-06-30', 6),
('Gasas estériles (paquete 50)', 'Insumos', 22, 15, 180.00, '2026-08-15', 6),
('Alcohol 70% (1 litro)', 'Desinfectantes', 18, 12, 290.00, '2025-12-20', 6),
('Suero fisiológico (500ml)', 'Soluciones', 35, 20, 145.00, '2025-10-30', 6),
-- Instrumental
('Termómetro digital veterinario', 'Instrumental', 5, 3, 1560.00, NULL, 3),
('Estetoscopio veterinario', 'Instrumental', 3, 2, 3200.00, NULL, 3),
('Otoscopio con espéculos', 'Instrumental', 2, 1, 4800.00, NULL, 3),
('Tijeras quirúrgicas curvas', 'Instrumental', 6, 4, 2100.00, NULL, 8),
-- Alimentos especiales
('Alimento Renal Canino (15kg)', 'Alimentos', 12, 8, 3400.00, '2025-09-15', 4),
('Alimento Hepatico Felino (4kg)', 'Alimentos', 7, 5, 2200.00, '2025-10-20', 4),
('Suplemento Vitamínico (100ml)', 'Suplementos', 20, 10, 890.00, '2025-12-10', 4),
-- Productos de limpieza
('Desinfectante de superficies (5L)', 'Limpieza', 6, 8, 1200.00, '2025-11-30', 9),
('Jabón quirúrgico (500ml)', 'Limpieza', 10, 6, 650.00, '2025-08-25', 9),
-- Análisis
('Kit análisis sangre (10 tests)', 'Análisis', 15, 12, 2800.00, '2025-06-15', 5),
('Reactivo química sanguínea', 'Análisis', 8, 6, 3200.00, '2025-07-20', 5);

-- Tabla: empleado (8 registros)
INSERT INTO empleado (nombre, apellido, cargo, telefono, email, fecha_ingreso, salario, horario) VALUES
('Sofía', 'Martínez', 'Recepcionista Senior', '2708-1234', 'sofia.martinez@veterinariabouvier.com.uy', '2022-03-15', 45000.00, 'Lunes a Viernes 8:00-18:00'),
('Juan Carlos', 'Rodríguez', 'Técnico Veterinario', '2901-5678', 'juancarlos.rodriguez@veterinariabouvier.com.uy', '2021-08-10', 52000.00, 'Lunes a Sábado 9:00-17:00'),
('María Elena', 'González', 'Auxiliar de Cirugía', '2403-9876', 'mariaelena.gonzalez@veterinariabouvier.com.uy', '2023-01-20', 48000.00, 'Martes a Sábado 10:00-18:00'),
('Roberto', 'Silva', 'Encargado de Inventario', '2605-2468', 'roberto.silva@veterinariabouvier.com.uy', '2020-11-05', 50000.00, 'Lunes a Viernes 8:30-17:30'),
('Carmen', 'López', 'Secretaria Administrativa', '2502-7890', 'carmen.lopez@veterinariabouvier.com.uy', '2022-09-12', 42000.00, 'Lunes a Viernes 9:00-17:00'),
('Diego', 'Fernández', 'Técnico en Radiología', '2709-3456', 'diego.fernandez@veterinariabouvier.com.uy', '2023-05-08', 55000.00, 'Lunes a Viernes 10:00-19:00'),
('Patricia', 'Morales', 'Auxiliar de Laboratorio', '2408-6543', 'patricia.morales@veterinariabouvier.com.uy', '2022-07-25', 46000.00, 'Martes a Sábado 8:00-16:00'),
('Fernando', 'Castro', 'Supervisor de Limpieza', '2601-8642', 'fernando.castro@veterinariabouvier.com.uy', '2021-02-18', 38000.00, 'Lunes a Sábado 7:00-15:00');

-- Tabla: facturacion (30 registros)
INSERT INTO facturacion (propietario_id, fecha_factura, total, descuento, forma_pago, estado_pago, fecha_vencimiento) VALUES
-- Facturas 2024 - Enero
(1, '2024-01-15', 2500.00, 0.00, 'TARJETA', 'PAGADO', '2024-02-15'),
(3, '2024-01-20', 1800.00, 5.00, 'EFECTIVO', 'PAGADO', '2024-02-20'),
(5, '2024-01-25', 3200.00, 10.00, 'TRANSFERENCIA', 'PAGADO', '2024-02-25'),
-- Facturas 2024 - Febrero
(7, '2024-02-10', 1200.00, 0.00, 'TARJETA', 'PAGADO', '2024-03-10'),
(2, '2024-02-18', 4500.00, 15.00, 'CHEQUE', 'PAGADO', '2024-03-18'),
(9, '2024-02-22', 900.00, 0.00, 'EFECTIVO', 'PAGADO', '2024-03-22'),
-- Facturas 2024 - Marzo
(4, '2024-03-05', 2100.00, 0.00, 'TRANSFERENCIA', 'PAGADO', '2024-04-05'),
(11, '2024-03-12', 1600.00, 8.00, 'TARJETA', 'PAGADO', '2024-04-12'),
(6, '2024-03-28', 3800.00, 20.00, 'TRANSFERENCIA', 'PAGADO', '2024-04-28'),
-- Facturas 2024 - Abril a Agosto (pagadas)
(8, '2024-04-15', 2200.00, 0.00, 'TARJETA', 'PAGADO', '2024-05-15'),
(12, '2024-05-20', 1500.00, 5.00, 'EFECTIVO', 'PAGADO', '2024-06-20'),
(14, '2024-06-10', 2800.00, 12.00, 'TRANSFERENCIA', 'PAGADO', '2024-07-10'),
(16, '2024-07-25', 1900.00, 0.00, 'TARJETA', 'PAGADO', '2024-08-25'),
(18, '2024-08-30', 3500.00, 18.00, 'CHEQUE', 'PAGADO', '2024-09-30'),
-- Facturas 2024 - Septiembre (algunas pendientes)
(10, '2024-09-05', 1400.00, 0.00, 'TARJETA', 'PAGADO', '2024-10-05'),
(13, '2024-09-15', 2600.00, 10.00, 'TRANSFERENCIA', 'PENDIENTE', '2024-10-15'),
(15, '2024-09-20', 1800.00, 0.00, 'EFECTIVO', 'PAGADO', '2024-10-20'),
(17, '2024-09-28', 2200.00, 5.00, 'TARJETA', 'PENDIENTE', '2024-10-28'),
-- Facturas 2024 - Octubre (recientes, algunas pendientes y vencidas)
(19, '2024-10-02', 3200.00, 15.00, 'TRANSFERENCIA', 'PENDIENTE', '2024-11-02'),
(20, '2024-10-08', 1700.00, 0.00, 'TARJETA', 'PAGADO', '2024-11-08'),
(1, '2024-10-12', 2900.00, 12.00, 'CHEQUE', 'PENDIENTE', '2024-11-12'),
(3, '2024-10-15', 1300.00, 0.00, 'EFECTIVO', 'PAGADO', '2024-11-15'),
-- Facturas vencidas (septiembre sin pagar)
(5, '2024-09-01', 2400.00, 8.00, 'TRANSFERENCIA', 'VENCIDO', '2024-10-01'),
(7, '2024-09-10', 1900.00, 0.00, 'TARJETA', 'VENCIDO', '2024-10-10'),
-- Facturas históricas 2023
(2, '2023-12-15', 2100.00, 0.00, 'TARJETA', 'PAGADO', '2024-01-15'),
(4, '2023-11-20', 1800.00, 5.00, 'EFECTIVO', 'PAGADO', '2023-12-20'),
(6, '2023-10-25', 3400.00, 20.00, 'TRANSFERENCIA', 'PAGADO', '2023-11-25'),
(8, '2023-09-30', 1600.00, 0.00, 'TARJETA', 'PAGADO', '2023-10-30'),
(11, '2023-08-18', 2800.00, 15.00, 'CHEQUE', 'PAGADO', '2023-09-18'),
(14, '2023-07-22', 2200.00, 10.00, 'TRANSFERENCIA', 'PAGADO', '2023-08-22');

-- Tabla: recordatorio (35 registros)
INSERT INTO recordatorio (mascota_id, tipo_recordatorio, fecha_programada, mensaje, estado, fecha_enviado) VALUES
-- Recordatorios de vacunas (próximas)
(1, 'VACUNA', '2025-01-15', 'Recordatorio: Refuerzo anual de Hexadog para Max. Por favor programar cita.', 'PENDIENTE', NULL),
(2, 'VACUNA', '2025-02-20', 'Recordatorio: Vacunación anual para Luna. Consultar plan de vacunación.', 'PENDIENTE', NULL),
(3, 'VACUNA', '2025-03-10', 'Recordatorio: Control de vacunas para Rocky. Revisar calendario.', 'PENDIENTE', NULL),
(16, 'VACUNA', '2025-01-25', 'Recordatorio: Vacuna felina anual para Mimi. Importante no demorar.', 'PENDIENTE', NULL),
(17, 'VACUNA', '2025-02-15', 'Recordatorio: VILEF y vacunas básicas para Garfield.', 'PENDIENTE', NULL),
-- Recordatorios de control (rutina)
(4, 'CONTROL', '2024-11-20', 'Control médico semestral para Bella. Verificar peso y desarrollo.', 'PENDIENTE', NULL),
(5, 'CONTROL', '2024-12-01', 'Control respiratorio para Toby (Bulldog Francés). Importante por raza.', 'PENDIENTE', NULL),
(6, 'CONTROL', '2024-11-15', 'Control auditivo para Lola. Revisión de otitis previa.', 'PENDIENTE', NULL),
(7, 'CONTROL', '2024-12-10', 'Control ortopédico para Bruno. Chequeo de articulaciones.', 'PENDIENTE', NULL),
(10, 'CONTROL', '2024-11-30', 'Control geriátrico para Zeus (Rottweiler). Análisis completo.', 'PENDIENTE', NULL),
-- Recordatorios de tratamiento (en curso)
(8, 'TRATAMIENTO', '2024-10-25', 'Continuar tratamiento dermatológico para Coco. Aplicar medicación.', 'ENVIADO', '2024-10-20 09:30:00'),
(12, 'TRATAMIENTO', '2024-11-05', 'Seguimiento de tratamiento dental para Thor. Control de evolución.', 'PENDIENTE', NULL),
(15, 'TRATAMIENTO', '2024-10-30', 'Medicación post-cirugía para Dora. Seguir indicaciones estrictas.', 'ENVIADO', '2024-10-25 14:15:00'),
-- Recordatorios de cirugía (seguimiento)
(1, 'CIRUGIA_SEGUIMIENTO', '2024-10-30', 'Control post-cirugía para Max. Revisar cicatrización de tumor.', 'ENVIADO', '2024-10-28 16:45:00'),
(11, 'CIRUGIA_SEGUIMIENTO', '2024-11-10', 'Seguimiento post-cirugía para Nina. Control de herida quirúrgica.', 'PENDIENTE', NULL),
-- Recordatorios completados (históricos)
(9, 'VACUNA', '2024-09-15', 'Vacunación anual completada para Mía. Próxima cita en 2025.', 'COMPLETADO', '2024-09-10 11:20:00'),
(13, 'CONTROL', '2024-08-20', 'Control cardiológico completado para Kiara. Resultados normales.', 'COMPLETADO', '2024-08-15 10:30:00'),
(14, 'TRATAMIENTO', '2024-09-01', 'Tratamiento completado para Simba. Alta médica otorgada.', 'COMPLETADO', '2024-08-28 15:45:00'),
(18, 'VACUNA', '2024-07-15', 'Vacunación felina completada para Salem. Próxima dosis programada.', 'COMPLETADO', '2024-07-10 12:00:00'),
(20, 'CONTROL', '2024-08-30', 'Control geriátrico completado para Felix. Ajustar dieta.', 'COMPLETADO', '2024-08-25 09:15:00'),
-- Recordatorios cancelados
(22, 'VACUNA', '2024-06-15', 'Vacunación cancelada para Pepe por enfermedad. Reprogramar.', 'CANCELADO', NULL),
(24, 'CONTROL', '2024-07-20', 'Control cancelado para Chispa por viaje del propietario.', 'CANCELADO', NULL),
-- Recordatorios diversos
(21, 'OTROS', '2024-11-25', 'Recordatorio: Cambio de dieta especial para Bugs (conejo). Nueva marca de pellets.', 'PENDIENTE', NULL),
(23, 'OTROS', '2024-12-05', 'Recordatorio: Corte de uñas para Nemo. Programar cita de estética.', 'PENDIENTE', NULL),
(25, 'OTROS', '2024-11-18', 'Recordatorio: Desparasitación externa para Copito. Producto específico para conejos.', 'PENDIENTE', NULL),
-- Recordatorios de emergencia enviados
(5, 'CONTROL', '2024-10-18', 'URGENTE: Control respiratorio para Toby. Síntomas preocupantes reportados.', 'ENVIADO', '2024-10-18 08:00:00'),
(3, 'CONTROL', '2024-09-28', 'Control oftalmológico urgente para Rocky. Empeoramiento de cataratas.', 'ENVIADO', '2024-09-28 13:30:00'),
-- Recordatorios futuros programados
(4, 'VACUNA', '2025-04-10', 'Recordatorio: Vacunación anual programada para Bella en primavera.', 'PENDIENTE', NULL),
(6, 'CONTROL', '2025-03-25', 'Control preventivo programado para Lola. Chequeo general primaveral.', 'PENDIENTE', NULL),
(8, 'OTROS', '2025-02-20', 'Recordatorio: Análisis de rutina para Coco. Chequeo anual completo.', 'PENDIENTE', NULL),
-- Recordatorios para mascotas geriátricas
(10, 'CONTROL', '2025-01-30', 'Control geriátrico especializado para Zeus. Análisis de función renal.', 'PENDIENTE', NULL),
(12, 'TRATAMIENTO', '2025-02-10', 'Tratamiento preventivo para Thor. Cuidados por edad avanzada.', 'PENDIENTE', NULL),
-- Recordatorios para mascotas jóvenes
(19, 'VACUNA', '2025-01-10', 'Recordatorio: Segunda vacuna felina para Pelusa. Completar esquema básico.', 'PENDIENTE', NULL),
(21, 'CONTROL', '2025-01-20', 'Control de crecimiento para Bugs (conejo joven). Verificar desarrollo.', 'PENDIENTE', NULL),
(23, 'VACUNA', '2025-03-15', 'Recordatorio: Vacunación felina para Nemo. Esquema de refuerzo.', 'PENDIENTE', NULL);

