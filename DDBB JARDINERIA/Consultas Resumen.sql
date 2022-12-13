
-- CONSULTAS RESUMEN

-- 1. ¿Cuántos empleados hay en la compañía?
select count(*) as Num_empleados from empleado;

-- 2. ¿Cuántos clientes tiene cada país?
select count(*) as Num_Clientes, pais from cliente
group by pais;

-- 3. ¿Cuál fue el pago medio en 2009?
select avg(pago.total) as Pago_Medio from pago
where extract(year from fecha_pago)=2009;

-- 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
select count(*) as Num_Pedidos, estado from pedido
group by estado
order by count(*) desc;

-- 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
select max(precio_venta) as Producto_mas_Caro, min(precio_venta) as Producto_mas_Barato from producto;

-- 6. Calcula el número de clientes que tiene la empresa.
select count(*) as Num_Clientes from cliente;

-- 7. ¿Cuántos clientes tiene la ciudad de Madrid?
select count(*) as Clientes_Madrid from cliente
where region = 'Madrid';

-- 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
select count(*) as Clientes_M, ciudad from cliente
where ciudad like 'M%'
group by ciudad;

-- 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
select empleado.nombre as Representante_Ventas, count(codigo_cliente) as Num_Clientes from empleado
join cliente on empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas
where puesto = 'Representante Ventas'
group by empleado.nombre;

-- 10. Calcula el número de clientes que no tiene asignado representante de ventas.
select count(*) as Clientes_sin_Representante from cliente
where codigo_empleado_rep_ventas is null;

-- 11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. 
-- El listado deberá mostrar el nombre y los apellidos de cada cliente.
select nombre_cliente, min(fecha_pago) as Primer_Pedido, max(fecha_pago) as Último_Pedido from cliente
join pago 
group by nombre_cliente;

-- 12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
select codigo_pedido, count(codigo_producto) from detalle_pedido
group by codigo_pedido;

-- 13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
select codigo_pedido, sum(cantidad) from detalle_pedido
group by codigo_pedido;

-- 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
-- El listado deberá estar ordenado por el número total de unidades vendidas.
select codigo_producto, sum(cantidad) Total_Unidades from detalle_pedido
group by codigo_producto order by Total_Unidades desc limit 20;

-- 15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, 
-- el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por 
-- el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, 
-- y el total la suma de los dos campos anteriores.

select sum(precio_unidad*cantidad) as Base_Imponible, sum(precio_unidad*cantidad)*0.21 as IVA, 
sum(((precio_unidad*cantidad)*0.21)+(precio_unidad*cantidad)) as Total_Facturado from detalle_pedido;


-- 16. La misma información que en la pregunta anterior, pero agrupada por código de producto.

select codigo_producto, sum(precio_unidad*cantidad) as Base_Imponible, sum(precio_unidad*cantidad)*0.21 as IVA, 
sum(((precio_unidad*cantidad)*0.21)+(precio_unidad*cantidad)) as Total_Facturado from detalle_pedido
group by codigo_producto;


-- 17. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada 
-- por los códigos que empiecen por OR.

select codigo_producto, sum(precio_unidad*cantidad) as Base_Imponible, sum(precio_unidad*cantidad)*0.21 as IVA, 
sum(((precio_unidad*cantidad)*0.21)+(precio_unidad*cantidad)) as Total_Facturado from detalle_pedido
where codigo_producto like 'OR%'
group by codigo_producto;

-- 18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. 
-- Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).

select producto.nombre, cantidad, sum(precio_unidad*cantidad) as Total_Facturado, 
sum(((precio_unidad*cantidad)*0.21)+(precio_unidad*cantidad)) as Total_Facturado_IVA from detalle_pedido
join producto on detalle_pedido.codigo_producto = producto.codigo_producto
group by producto.nombre order by Total_Facturado_IVA>=3000;














