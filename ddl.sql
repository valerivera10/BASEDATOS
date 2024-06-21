CREATE DATABASE logistica;

USE logistica;

CREATE TABLE paises (
    pais_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE ciudades (
    ciudad_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais_id INT,
    FOREIGN KEY (pais_id) REFERENCES paises(pais_id)
);

CREATE TABLE sucursales (
    sucursal_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    ciudad_id INT,
    FOREIGN KEY (ciudad_id) REFERENCES ciudades(ciudad_id)
);

CREATE TABLE vehiculos (
    vehiculo_id INT PRIMARY KEY,
    placa VARCHAR(20) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    capacidad_carga DECIMAL(10,2) NOT NULL,
    sucursal_id INT,
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE conductores (
    conductor_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE telefonos_conductores (
    telefono_id INT PRIMARY KEY,
    numero VARCHAR(20) NOT NULL,
    conductor_id INT,
    FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id)
);

CREATE TABLE rutas (
    ruta_id INT PRIMARY KEY,
    descripcion VARCHAR(200) NOT NULL,
    sucursal_id INT,
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE conductores_rutas (
    conductor_id INT,
    ruta_id INT,
    vehiculo_id INT,
    sucursal_id INT,
    PRIMARY KEY (conductor_id, ruta_id),
    FOREIGN KEY (conductor_id) REFERENCES conductores(conductor_id),
    FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(vehiculo_id),
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE auxiliares (
    auxiliar_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE ruta_auxiliares (
    ruta_id INT,
    auxiliar_id INT,
    PRIMARY KEY (ruta_id, auxiliar_id),
    FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    FOREIGN KEY (auxiliar_id) REFERENCES auxiliares(auxiliar_id)
);

CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL
);

CREATE TABLE telefonos_clientes (
    telefono_id INT PRIMARY KEY,
    numero VARCHAR(20) NOT NULL,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE paquetes (
    paquete_id INT PRIMARY KEY,
    numero_seguimiento VARCHAR(50) NOT NULL,
    peso DECIMAL(10,2) NOT NULL,
    dimensiones VARCHAR(50) NOT NULL,
    contenido TEXT NOT NULL,
    valor_declarado DECIMAL(10,2) NOT NULL,
    tipo_servicio VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL
);

CREATE TABLE envios (
    envio_id INT PRIMARY KEY,
    cliente_id INT,
    paquete_id INT,
    fecha_envio TIMESTAMP NOT NULL,
    destino VARCHAR(200) NOT NULL,
    ruta_id INT,
    sucursal_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id),
    FOREIGN KEY (ruta_id) REFERENCES rutas(ruta_id),
    FOREIGN KEY (sucursal_id) REFERENCES sucursales(sucursal_id)
);

CREATE TABLE seguimiento (
    seguimiento_id INT PRIMARY KEY,
    paquete_id INT,
    ubicacion VARCHAR(200) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (paquete_id) REFERENCES paquetes(paquete_id)
);
