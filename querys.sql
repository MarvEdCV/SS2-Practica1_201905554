-- CONSULTAS
-- 1
SELECT 'ciudad' AS tabla, COUNT(*) AS cantidad FROM ciudad
UNION ALL
SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL
SELECT 'empleado', COUNT(*) FROM empleado
UNION ALL
SELECT 'entregas_estado', COUNT(*) FROM entregas_estado
UNION ALL
SELECT 'producto', COUNT(*) FROM producto
UNION ALL
SELECT 'tiempo', COUNT(*) FROM tiempo
UNION ALL
SELECT 'entregas', COUNT(*) FROM entregas;

-- 2
SELECT TOP 5 c.nombre AS Cliente, COUNT(e.id) AS EntregasRealizadas
FROM cliente c
INNER JOIN entregas e ON c.id_cliente = e.id_cliente
GROUP BY c.nombre
ORDER BY EntregasRealizadas DESC;

-- 3
SELECT TOP 5 p.nombre AS Producto, MAX(e.costo) AS CostoEnvioMaximo
FROM producto p
INNER JOIN entregas e ON p.id_producto = e.id_producto
GROUP BY p.nombre
ORDER BY CostoEnvioMaximo DESC;

-- 4
SELECT TOP 5 c.nombre AS Ciudad, COUNT(e.id) AS TotalEntregas
FROM ciudad c
INNER JOIN entregas e ON c.id_ciudad = e.id_ciudad
GROUP BY c.nombre
ORDER BY TotalEntregas DESC;

-- 5
SELECT TOP 5 e.id AS ID_Entrega, e.costo AS CostoEnvio
FROM entregas e
INNER JOIN entregas_estado ee ON e.id_entregas_estado = ee.id_entregas_estado
WHERE ee.nombre = 'Pendiente'
ORDER BY CostoEnvio DESC;

-- 6
SELECT TOP 5 e.id AS ID_Entrega, e.costo AS CostoEnvio
FROM entregas e
INNER JOIN entregas_estado ee ON e.id_entregas_estado = ee.id_entregas_estado
WHERE ee.nombre = 'Entregado'
ORDER BY CostoEnvio DESC;

-- 7
SELECT c.nombre AS Ciudad, COUNT(e.id) AS TotalEntregas
FROM ciudad c
LEFT JOIN entregas e ON c.id_ciudad = e.id_ciudad
GROUP BY c.nombre;

-- 8
SELECT t.dia AS DiaSemana, COUNT(e.id) AS TotalEntregas
FROM tiempo t
LEFT JOIN entregas e ON t.id_tiempo = e.id_tiempo
GROUP BY t.dia;

-- 9
SELECT t.mes AS Mes, COUNT(e.id) AS TotalEntregas
FROM tiempo t
LEFT JOIN entregas e ON t.id_tiempo = e.id_tiempo
GROUP BY t.mes;

-- 10
SELECT t.anio AS Anio, COUNT(e.id) AS TotalEntregas
FROM tiempo t
LEFT JOIN entregas e ON t.id_tiempo = e.id_tiempo
GROUP BY t.anio;
