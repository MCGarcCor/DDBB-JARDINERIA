USE jardineria;
-- CONSULTAS MULTITABLA (COMPOSICIÓN EXTERNA)

-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.
-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
select nombre_cliente from cliente 
left join pago on pago.codigo_cliente = cliente.codigo_cliente
where pago.codigo_cliente is null;

-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
select nombre_cliente from cliente
left join pedido on cliente.codigo_cliente = pedido.codigo_cliente
where pedido.codigo_cliente is null;

-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
select cliente.nombre_cliente from cliente
left join pedido on cliente.codigo_cliente = pedido.codigo_cliente
left join pago on pago.codigo_cliente = cliente.codigo_cliente
where pedido.codigo_cliente is null and pago.codigo_cliente is null;

-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
select empleado.nombre from empleado
left join oficina on oficina.codigo_oficina = empleado.codigo_oficina
where empleado.codigo_oficina is null; 

-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

select empleado.nombre from empleado
left join cliente on codigo_empleado = codigo_empleado_rep_ventas
where codigo_empleado_rep_ventas is null;

-- 6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
select empleado.nombre, oficina.* from empleado
left join cliente on codigo_empleado = codigo_empleado_rep_ventas
left join oficina on empleado.codigo_oficina = oficina.codigo_oficina
where codigo_empleado_rep_ventas is null;

-- 7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
select empleado.nombre from empleado
left join cliente on codigo_empleado = codigo_empleado_rep_ventas
left join oficina on oficina.codigo_oficina = empleado.codigo_oficina
where oficina.codigo_oficina is null and codigo_empleado_rep_ventas is null; 


-- 8. Devuelve un listado de los productos que nunca han aparecido en un pedido.
select producto.nombre from producto
left join detalle_pedido on producto.codigo_producto = detalle_pedido.codigo_producto
where detalle_pedido.codigo_producto is null;

-- 9. Devuelve un listado de los productos que nunca han aparecido en un pedido. 
-- El resultado debe mostrar el nombre, la descripción y la imagen del producto.
select producto.nombre, descripcion, imagen from producto
left join detalle_pedido on producto.codigo_producto = detalle_pedido.codigo_producto
left join gama_producto on imagen
where detalle_pedido.codigo_producto is null;

-- 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido 
-- los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
select * from oficina
left join empleado on empleado.codigo_oficina = oficina.codigo_oficina
left join cliente on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
left join pedido on pedido.codigo_cliente = cliente.codigo_cliente
left join detalle_pedido on detalle_pedido.codigo_pedido = pedido.codigo_pedido
left join producto on producto.codigo_producto = detalle_pedido.codigo_producto
where producto.gama = "Frutales" and cliente.codigo_empleado_rep_ventas <> any 
									(select codigo_empleado from empleado
                                    join oficina on oficina.codigo_oficina = empleado.codigo_oficina);


-- 11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
select cliente.nombre_cliente from cliente
left join pedido on cliente.codigo_cliente = pedido.codigo_cliente
left join pago on pago.codigo_cliente = cliente.codigo_cliente
where pago.codigo_cliente is null;


-- 12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

select empl.nombre, empl.apellido1, jef.nombre as jefe_nombre from empleado empl
join empleado jef on empl.codigo_empleado=jef.codigo_jefe
left join cliente on empl.codigo_empleado= codigo_empleado_rep_ventas
where codigo_empleado_rep_ventas is null;

 

