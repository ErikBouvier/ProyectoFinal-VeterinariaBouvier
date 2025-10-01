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
-- FIN DE LA INSERCIÓN DE DATOS
-- ========================================