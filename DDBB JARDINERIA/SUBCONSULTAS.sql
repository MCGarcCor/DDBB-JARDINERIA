

-- Con operadores básicos de comparación
-- 1. Devuelve el nombre del cliente con mayor límite de crédito.
select nombre_cliente, limite_credito from cliente
where limite_credito = (select max(limite_credito) from cliente);

-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.
select producto.nombre, precio_venta from producto
where precio_venta = (select max(precio_venta) from producto);

-- 3. Devuelve el nombre del producto del que se han vendido más unidades. 
-- (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que 
-- se han vendido de cada producto a partir de los datos de la tabla detalle_pedido. 
-- Una vez que sepa cuál es el código del producto, puede obtener su nombre fácilmente.).

select producto.nombre, cantidad as Unidades from producto
join detalle_pedido on producto.codigo_producto = detalle_pedido.codigo_producto
where cantidad = (select max(cantidad) from detalle_pedido);


-- 4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).

select nombre_cliente, limite_credito, total as Total_Pagos from cliente, pago
where limite_credito>total;

-- 5. Devuelve el producto que más unidades tiene en stock.
select producto.nombre, cantidad_en_stock from producto
where cantidad_en_stock = (select max(cantidad_en_stock) from producto);

-- 6. Devuelve el producto que menos unidades tiene en stock.
select producto.nombre, cantidad_en_stock from producto
where cantidad_en_stock = (select min(cantidad_en_stock) from producto);

-- 7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
select empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.email from empleado
where codigo_jefe = (select codigo_empleado from empleado where nombre like 'Alberto%');


-- Subconsultas con ALL y ANY
-- 8. Devuelve el nombre del cliente con mayor límite de crédito.
select nombre_cliente, limite_credito from cliente
where limite_credito = all (select max(limite_credito) from cliente);

-- 9. Devuelve el nombre del producto que tenga el precio de venta más caro.
select producto.nombre, precio_venta from producto
where precio_venta = all (select max(precio_venta) from producto);

-- 10. Devuelve el producto que menos unidades tiene en stock.
select producto.nombre, cantidad_en_stock from producto
where cantidad_en_stock >= any (select max(cantidad_en_stock) from producto);


-- Subconsultas con IN y NOT IN
-- 11. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
select e.nombre, e.apellido1, puesto from empleado e join cliente 
where codigo_empleado not in (select codigo_empleado_rep_ventas from cliente);

-- 12. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
select nombre_cliente from cliente where cliente.codigo_cliente not in (select codigo_cliente from pago);

-- 13. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
select nombre_cliente from cliente where cliente.codigo_cliente in (select codigo_cliente from pago);

-- 14. Devuelve un listado de los productos que nunca han aparecido en un pedido.
select codigo_producto, producto.nombre from producto
where codigo_producto not in (select codigo_producto from detalle_pedido);

-- 15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no 
-- sean representante de ventas de ningún cliente.
select em.nombre, em.apellido1, em.apellido2, puesto, telefono from empleado em
left join oficina on em.codigo_oficina=oficina.codigo_oficina
where em.codigo_empleado not in (select codigo_empleado_rep_ventas from cliente);


-- 16. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido 
-- los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

select oficina.codigo_oficina from oficina
left join empleado on empleado.codigo_oficina=oficina.codigo_oficina
left join cliente on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas 
left join pedido on pedido.codigo_cliente = cliente.codigo_cliente
left join detalle_pedido on detalle_pedido.codigo_pedido=pedido.codigo_pedido
left join producto on producto.codigo_producto=detalle_pedido.codigo_producto
where producto.gama = 'Frutales' and empleado.codigo_empleado not in (select codigo_oficina from oficina) ;
                                        


-- 17. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

select * from cliente
left join pedido on pedido.codigo_cliente=cliente.codigo_cliente
where cliente.codigo_cliente not in (select codigo_cliente from pago);

-- Subconsultas con EXISTS y NOT EXISTS
-- 18. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
select * from cliente 
where not exists (select codigo_cliente from pago);

-- 19. Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
select * from cliente 
where exists (select codigo_cliente from pago);

-- 20. Devuelve un listado de los productos que nunca han aparecido en un pedido.
select * from producto
where not exists (select codigo_producto from detalle_pedido);

-- 21. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.

select * from producto
where exists (select codigo_producto from detalle_pedido);















