-- Inserciones en la tabla paises
INSERT INTO paises (id, nombre) VALUES (1, 'Colombia');
INSERT INTO paises (id, nombre) VALUES (2, 'Argentina');

-- Inserciones en la tabla ciudades
INSERT INTO ciudades (id, nombre, pais_id) VALUES (1, 'Bogotá', 1);
INSERT INTO ciudades (id, nombre, pais_id) VALUES (2, 'Medellín', 1);
INSERT INTO ciudades (id, nombre, pais_id) VALUES (3, 'Buenos Aires', 2);

-- Inserciones en la tabla sucursales
INSERT INTO sucursales (id, nombre, direccion, ciudad_id) VALUES (1, 'Sucursal Bogotá', 'Calle 123 #45-67', 1);
INSERT INTO sucursales (id, nombre, direccion, ciudad_id) VALUES (2, 'Sucursal Medellín', 'Carrera 89 #12-34', 2);
INSERT INTO sucursales (id, nombre, direccion, ciudad_id) VALUES (3, 'Sucursal Buenos Aires', 'Avenida 9 de Julio 1234', 3);

-- Inserciones en la tabla rutas
INSERT INTO rutas (id, descripcion, sucursal_id) VALUES (1, 'Ruta 1 - Bogotá', 1);
INSERT INTO rutas (id, descripcion, sucursal_id) VALUES (2, 'Ruta 2 - Medellín', 2);
INSERT INTO rutas (id, descripcion, sucursal_id) VALUES (3, 'Ruta 3 - Buenos Aires', 3);

-- Inserciones en la tabla conductores
INSERT INTO conductores (id, nombre) VALUES (1, 'Juan Pérez');
INSERT INTO conductores (id, nombre) VALUES (2, 'Carlos Gómez');
INSERT INTO conductores (id, nombre) VALUES (3, 'María Rodríguez');

-- Inserciones en la tabla paquetes
INSERT INTO paquetes (id, numero_seguimiento, peso, dimensiones, contenido, valor_declarado, tipo_servicio, estado) VALUES
(1, 'PAQ12345', 10.5, '30x30x30', 'Ropa', 200.00, 'Express', 'En tránsito'),
(2, 'PAQ67890', 2.0, '20x20x20', 'Libros', 50.00, 'Estándar', 'Entregado'),
(3, 'PAQ54321', 5.3, '25x25x25', 'Electrónica', 500.00, 'Express', 'Pendiente');

-- Inserciones en la tabla clientes
INSERT INTO clientes (id, nombre, email, direccion) VALUES
(1, 'Luis Martínez', 'luis.martinez@example.com', 'Calle Falsa 123'),
(2, 'Ana Torres', 'ana.torres@example.com', 'Avenida Siempreviva 456'),
(3, 'Pedro Sánchez', 'pedro.sanchez@example.com', 'Carrera Central 789');

-- Inserciones en la tabla telefono_clientes
INSERT INTO telefono_clientes (id, numero, cliente_id) VALUES
(1, '3211234567', 1),
(2, '3109876543', 2),
(3, '3165432198', 3);

-- Inserciones en la tabla envios
INSERT INTO envios (id, ruta_id, cliente_id, fecha_envio, destino, sucursal_id, paquete_id) VALUES
(1, 1, 1, '2023-06-01 10:00:00', 'Calle 10 #20-30', 1, 1),
(2, 2, 2, '2023-06-02 11:00:00', 'Carrera 50 #60-70', 2, 2),
(3, 3, 3, '2023-06-03 12:00:00', 'Avenida 7 #80-90', 3, 3);

-- Inserciones en la tabla seguimiento
INSERT INTO seguimiento (id, paquete_id, ubicacion, fecha_hora, estado) VALUES
(1, 1, 'Bogotá', '2023-06-01 11:00:00', 'En tránsito'),
(2, 2, 'Medellín', '2023-06-02 12:00:00', 'Entregado'),
(3, 3, 'Buenos Aires', '2023-06-03 13:00:00', 'Pendiente');

-- Inserciones en la tabla conductores_rutas
INSERT INTO conductores_rutas (conductor_id, ruta_id, vehiculo_id, sucursal_id) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3);

-- Inserciones en la tabla telefonos_conductores
INSERT INTO telefonos_conductores (id, numero, conductor_id) VALUES
(1, '3001234567', 1),
(2, '3101234567', 2),
(3, '3201234567', 3);

-- Inserciones en la tabla auxiliares
INSERT INTO auxiliares (id, nombre, telefono) VALUES
(1, 'Auxiliar 1', '3002345678'),
(2, 'Auxiliar 2', '3102345678'),
(3, 'Auxiliar 3', '3202345678');

-- Inserciones en la tabla vehiculos
INSERT INTO vehiculos (id, placa, marca, modelo, capacidad_carga, sucursal_id) VALUES
(1, 'ABC123', 'Toyota', 'Hilux', 1000.00, 1),
(2, 'DEF456', 'Ford', 'Ranger', 1200.00, 2),
(3, 'GHI789', 'Nissan', 'Navara', 1500.00, 3);

-- Inserciones en la tabla ruta_auxiliares
INSERT INTO ruta_auxiliares (ruta_id, auxiliar_id) VALUES
(1, 1),
(2, 2),
(3, 3);



