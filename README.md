
--CONSULTAS--

-- Caso de Uso 15: Generar un Reporte de Envíos por Cliente Descripción: Un administrador desea generar un reporte de todos los envíos realizados por un cliente específico.

select envio_id 
from envios
where cliente_id=1;

select e.envio_id as ID, c.nombre, e.paquete_id
from envios AS e
inner join clientes AS c
on e.cliente_id = c.cliente_id
where c.nombre = 'Laura Martínez';

+----+-----------------+------------+
| ID | nombre          | paquete_id |
+----+-----------------+------------+
|  6 | Laura Martínez  |          6 |
+----+-----------------+------------+

-- Caso de Uso 16: Actualizar el Estado de un Paquete Descripción: Un administrador desea actualizar el estado de un paquete específico.

UPDATE paquetes 
SET estado = 'En tránsito'
WHERE paquete_id = 1;

-- Caso de Uso 17: Rastrear la Ubicación Actual de un Paquete Descripción: Un administrador desea rastrear la ubicación actual de un paquete específico.

SELECT paquete_id, estado
FROM seguimiento
WHERE paquete_id = '1';

+------------+--------------+
| paquete_id | estado       |
+------------+--------------+
|          1 | En almacén   |
|          1 | En tránsito  |
|          1 | Entregado    |
+------------+--------------+

-- CASOS MULTITABLA --

-- 1: Obtener Información Completa de Envíos 
-- Descripción: Un administrador desea obtener la información completa de todos los envíos,incluyendo detalles del cliente, paquete, ruta, conductor, y sucursal.

SELECT
    e.envio_id,
    c.cliente_id,
    c.nombre AS nombre_cliente,
    c.email AS email_cliente,
    c.direccion AS direccion_cliente,
    p.paquete_id,
    p.numero_seguimiento,
    p.peso,
    p.dimensiones,
    p.contenido,
    p.valor_declarado,
    p.tipo_servicio,
    p.estado AS estado_paquete,
    r.ruta_id,
    r.descripcion AS descripcion_ruta,
    s.sucursal_id,
    s.nombre AS nombre_sucursal,
    s.direccion AS direccion_sucursal,
    c2.conductor_id,
    c2.nombre AS nombre_conductor
FROM envios e
INNER JOIN clientes c 
ON e.cliente_id = c.cliente_id
INNER JOIN paquetes p 
ON e.paquete_id = p.paquete_id
LEFT JOIN rutas r 
ON e.ruta_id = r.ruta_id
LEFT JOIN sucursales s 
ON e.sucursal_id = s.sucursal_id
LEFT JOIN conductores_rutas cr 
ON e.ruta_id = cr.ruta_id AND e.sucursal_id = cr.sucursal_id
LEFT JOIN conductores c2 ON cr.conductor_id = c2.conductor_id;

-- Caso de Uso 2: Obtener Historial de Envíos de un Cliente
-- Descripción: Un administrador desea obtener el historial completo de envíos de un cliente específico, incluyendo detalles de los paquetes y los eventos de seguimiento.

SELECT
    e.envio_id,
    p.numero_seguimiento,
    p.peso,
    p.dimensiones,
    p.contenido,
    p.valor_declarado,
    p.tipo_servicio,
    p.estado AS estado_paquete,
    s.seguimiento_id,
    s.ubicacion,
    s.fecha_hora,
    s.estado AS estado_seguimiento
FROM envios e
INNER JOIN paquetes p ON e.paquete_id = p.paquete_id
LEFT JOIN seguimiento s ON p.paquete_id = s.paquete_id
WHERE e.cliente_id = 1; 

-- Caso de Uso 3: Listar Conductores y sus Rutas Asignadas
-- Descripción: Un administrador desea obtener una lista de todos los conductores y las rutas a las que están asignados, incluyendo detalles del vehículo utilizado y la sucursal correspondiente.

SELECT
    c.conductor_id,
    c.nombre AS nombre_conductor,
    r.ruta_id,
    r.descripcion AS descripcion_ruta,
    v.vehiculo_id,
    v.placa,
    v.marca,
    v.modelo,
    v.capacidad_carga,
    s.sucursal_id,
    s.nombre AS nombre_sucursal,
    s.direccion AS direccion_sucursal
FROM conductores c
INNER JOIN conductores_rutas cr ON c.conductor_id = cr.conductor_id
INNER JOIN rutas r ON cr.ruta_id = r.ruta_id
INNER JOIN vehiculos v ON cr.vehiculo_id = v.vehiculo_id
INNER JOIN sucursales s ON cr.sucursal_id = s.sucursal_id;

-- Caso de Uso 4: Obtener Detalles de Rutas y Auxiliares Asignados
-- Descripción: Un administrador desea obtener detalles de todas las rutas, incluyendo los auxiliares asignados a cada ruta.

SELECT
    r.ruta_id,
    r.descripcion AS descripcion_ruta,
    a.auxiliar_id,
    a.nombre AS nombre_auxiliar,
    a.telefono AS telefono_auxiliar
FROM rutas r
LEFT JOIN ruta_auxiliares ra ON r.ruta_id = ra.ruta_id
LEFT JOIN auxiliares a ON ra.auxiliar_id = a.auxiliar_id;


-- Caso de Uso 5: Generar Reporte de Paquetes por Sucursal y Estado
-- Descripción: Un administrador desea generar un reporte de todos los paquetes agrupados por sucursal y estado.

SELECT
    s.sucursal_id,
    s.nombre AS nombre_sucursal,
    p.estado AS estado_paquete,
    COUNT(p.paquete_id) AS cantidad_paquetes
FROM paquetes p
INNER JOIN envios e ON p.paquete_id = e.paquete_id
INNER JOIN sucursales s ON e.sucursal_id = s.sucursal_id
GROUP BY s.sucursal_id, p.estado
ORDER BY s.sucursal_id, p.estado;

-- caso 6 
SELECT p.paquete_id, p.numero_seguimiento, p.peso, p.dimensiones, p.contenido,
       p.valor_declarado, p.tipo_servicio, p.estado,
       s.seguimiento_id, s.ubicacion, s.fecha_hora, s.estado AS estado_seguimiento
FROM paquetes p
LEFT JOIN seguimiento s ON p.paquete_id = s.paquete_id
WHERE p.paquete_id = 1;




-- Casos de uso Between, In y Not In --

-- Caso de Uso 1: Obtener Paquetes Enviados Dentro de un Rango de Fechas 
-- Descripción: Un administrador desea obtener todos los paquetes que fueron enviados dentro de un rango de fechas específico. 

SELECT p.paquete_id  
FROM paquetes p
JOIN envios e
ON p.paquete_id=e.paquete_id
WHERE e.fecha_envio between " 2024-06-20" AND " 2024-06-22";


-- Caso de Uso 2: Obtener Paquetes con Ciertos Estados 
-- Descripción: Un administrador desea obtener todos los paquetes que tienen ciertos estados específicos (por ejemplo, 'en tránsito' o 'entregado'). 

SELECT p.paquete_id  
FROM paquetes p
JOIN seguimiento s
ON p.paquete_id=s.paquete_id
WHERE s.estado in ("Entregado") ;


--caso 3
    SELECT paquete_id, numero_seguimiento, peso, dimensiones, contenido, valor_declarado, tipo_servicio, estado
    FROM paquetes
    WHERE estado NOT IN ('recibido', 'retenido en aduana');

--caso 4
    SELECT DISTINCT c.cliente_id AS cliente_id, c.nombre AS cliente_nombre, c.email, c.direccion
    FROM clientes c
    JOIN envios e ON c.cliente_id = e.cliente_id
    WHERE e.fecha_envio BETWEEN '2023-06-01' AND '2023-06-02';


--caso 5
    SELECT c.conductor_id, c.nombre
    FROM conductores c
    LEFT JOIN conductores_rutas cr ON c.conductor_id = cr.conductor_id AND cr.ruta_id IN (1, 2)
    WHERE cr.ruta_id IS NULL;


-- Caso de Uso 6: Obtener Información de Paquetes con Valor Declarado Dentro de un Rango Específico 
-- Descripción: Un administrador desea obtener todos los paquetes cuyo valor declarado está dentro de un rango específico. 


SELECT paquete_id,numero_seguimiento,peso,contenido,valor_declarado
FROM paquetes
WHERE valor_declarado between 100 And 150;

+------------+--------------------+------+--------------+-----------------+
| paquete_id | numero_seguimiento | peso | contenido    | valor_declarado |
+------------+--------------------+------+--------------+-----------------+
|          1 | COL1001            | 5.20 | Libros       |          100.00 |
|          4 | USA1001            | 4.00 | Cosméticos   |          120.00 |
|          5 | ESP1001            | 6.50 | Juguetes     |          150.00 |
|          7 | MEX1001            | 4.80 | Herramientas |          130.00 |



-- Caso de Uso 7: Obtener Auxiliares Asignados a Rutas Específicas 
-- Descripción: Un administrador desea obtener todos los auxiliares de reparto que están asignados a ciertas rutas específicas. 

SELECT a.nombre
FROM Auxiliares AS a
JOIN Ruta_auxiliares AS ra
ON a.auxiliar_id =ra.auxiliar_id
WHERE   ruta_id=1;


| nombre     |
+------------+
| Ana López  |


-- Caso de Uso 8: Obtener Envíos a Destinos Excluyendo Ciertas Ciudades 
-- Descripción: Un administrador desea obtener todos los envíos cuyos destinos no están en ciertas ciudades específicas.

SELECT e.envio_id 
FROM envios AS e
JOIN sucursales AS s
ON e.sucursal_id=s.sucursal_id
JOIN ciudades AS c
ON  c.ciudad_id=s.ciudad_id
WHERE c.nombre not in("Medellín");


| envio_id |
+----------+
|        2 |
|        3 |
|        4 |
|        5 |
|        6 |
|        7 |


-- Caso de Uso 9: Obtener Seguimientos de Paquetes en un Rango de Fechas 
-- Descripción: Un administrador desea obtener todos los eventos de seguimiento de paquetes que ocurrieron dentro de un rango de fechas específico. 

SELECT envio_id
FROM seguimiento AS s
join paquetes AS p
ON p.paquete_id=s.paquete_id
join envios AS e
ON p.paquete_id=e.paquete_id 
WHERE date(fecha_envio) between " 2024-06-20" AND " 2024-06-22";

| envio_id |
+----------+
|        1 |
|        1 |
|        1 |
|        2 |
|        2 |
|        2 |
|        3 |
|        3 |
|        3 |
|        4 |
|        4 |
|        4 |
|        5 |
|        5 |
|        5 |
|        6 |
|        6 |
|        6 |
|        7 |
|        7 |
|        7 |


-- Caso de Uso 10: Obtener Clientes que Tienen Ciertos Tipos de Paquetes 
-- Descripción: Un administrador desea obtener todos los clientes que tienen paquetes de ciertos tipos específicos (por ejemplo, 'nacional' o 'internacional').



SELECT c.nombre
FROM clientes AS c
JOIN envios AS e
ON c.cliente_id=e.cliente_id
JOIN paquetes AS p
ON p.paquete_id=e.paquete_id
WHERE tipo_servicio="Express";

| nombre           |
+------------------+
| Juan Pérez       |
| Juan Pérez       |
| Carlos Ramírez   |
| Pedro Rodríguez  |


