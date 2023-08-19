USE ss2_practica1
-- CARGAR INFORMACION
INSERT INTO ciudad (nombre)
SELECT DISTINCT ciudad_entrega
FROM temporal;


INSERT INTO cliente (nombre, direccion)
SELECT DISTINCT nombre_cliente, direccion
FROM temporal;

INSERT INTO empleado (nombre, puesto)
SELECT DISTINCT nombre_empleado_entrega, puesto_empleado_entrega
FROM temporal;

INSERT INTO entregas_estado (nombre)
SELECT DISTINCT estado_entrega
FROM temporal
WHERE estado_entrega IS NOT NULL;

INSERT INTO producto (nombre, descripcion, peso, precio)
SELECT DISTINCT nombre_producto, descripcion, peso, precio_producto
FROM temporal
WHERE nombre_producto IS NOT NULL AND precio_producto IS NOT NULL;

INSERT INTO tiempo (dia, mes, anio)
SELECT DISTINCT dia, mes, anio
FROM temporal
WHERE anio IS NOT NULL;

INSERT INTO entregas (entrega_id, tiempo_entrega, costo, id_ciudad, id_cliente, id_empleado, id_entregas_estado, id_producto, id_tiempo)
SELECT t.id_entrega, t.tiempo_entrega, t.costo_envio, c.id_ciudad, cl.id_cliente, e.id_empleado, ee.id_entregas_estado, p.id_producto, ti.id_tiempo
FROM temporal t
INNER JOIN ciudad c ON t.ciudad_entrega = c.nombre
INNER JOIN cliente cl ON t.nombre_cliente = cl.nombre AND t.direccion = cl.direccion
INNER JOIN empleado e ON t.nombre_empleado_entrega = e.nombre AND t.puesto_empleado_entrega = e.puesto
INNER JOIN entregas_estado ee ON t.estado_entrega = ee.nombre
INNER JOIN producto p ON t.nombre_producto = p.nombre AND t.descripcion = p.descripcion AND t.peso = p.peso AND t.precio_producto = p.precio
INNER JOIN tiempo ti ON t.dia = ti.dia AND t.mes = ti.mes AND t.anio = ti.anio
WHERE t.id_entrega NOT IN (SELECT id_entrega FROM entregas) -- No duplicados
  AND t.anio IS NOT NULL
  AND t.nombre_producto IS NOT NULL
  AND t.estado_entrega IS NOT NULL
  AND t.precio_producto IS NOT NULL;


