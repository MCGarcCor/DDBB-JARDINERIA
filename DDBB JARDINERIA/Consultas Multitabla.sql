
-- CONSULTAS MULTITABLA 
-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
select nombre_cliente, nombre, apellido1, apellido2 from cliente join empleado
on codigo_empleado=codigo_empleado_rep_ventas;

select nombre_cliente, nombre, apellido1, apellido2 from cliente, empleado
where codigo_empleado=codigo_empleado_rep_ventas;

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
select nombre_cliente, nombre from cliente, empleado, pago
where codigo_empleado=codigo_empleado_rep_ventas and pago.codigo_cliente=cliente.codigo_cliente;

select nombre_cliente, nombre from cliente 
join empleado on codigo_empleado=codigo_empleado_rep_ventas 
join pago on pago.codigo_cliente=cliente.codigo_cliente;

-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

select nombre_cliente, empleado.nombre from cliente 
left join pago on pago.codigo_cliente = cliente.codigo_cliente
join empleado on codigo_empleado=codigo_empleado_rep_ventas
where pago.codigo_cliente is null;


-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select nombre_cliente, nombre, oficina.ciudad from cliente, empleado, pago, oficina
where codigo_empleado=codigo_empleado_rep_ventas 
and pago.codigo_cliente=cliente.codigo_cliente
and oficina.codigo_oficina=empleado.codigo_oficina;

select nombre_cliente, nombre, oficina.ciudad from cliente 
join empleado on codigo_empleado=codigo_empleado_rep_ventas 
join pago on pago.codigo_cliente=cliente.codigo_cliente
join oficina on oficina.codigo_oficina=empleado.codigo_oficina;

-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select nombre_cliente, empleado.nombre, oficina.ciudad from cliente 
left join pago on pago.codigo_cliente = cliente.codigo_cliente
join empleado on codigo_empleado=codigo_empleado_rep_ventas
join oficina on oficina.codigo_oficina=empleado.codigo_oficina
where pago.codigo_cliente is null;

-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select oficina.linea_direccion1, oficina.linea_direccion2 from oficina
join empleado on empleado.codigo_oficina=oficina.codigo_oficina
join cliente on empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas
where cliente.ciudad='Fuenlabrada'; 

-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select nombre_cliente, nombre, oficina.ciudad from cliente, empleado, oficina
where codigo_empleado=codigo_empleado_rep_ventas 
and oficina.codigo_oficina=empleado.codigo_oficina;

select nombre_cliente, nombre, oficina.ciudad from cliente 
join empleado on codigo_empleado=codigo_empleado_rep_ventas 
join oficina on oficina.codigo_oficina=empleado.codigo_oficina;

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

select empl.nombre, empl.apellido1, jef.nombre as jefe_nombre, jef.apellido1 as jefe_apellido1
from empleado empl, empleado jef
where empl.codigo_empleado=jef.codigo_jefe; 

select empl.nombre, empl.apellido1, jef.nombre as jefe_nombre, jef.apellido1 as jefe_apellido1
from empleado empl
join empleado jef
on empl.codigo_empleado=jef.codigo_jefe; 

-- 9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
select nombre_cliente from cliente, pedido
where fecha_entrega>fecha_esperada;

select nombre_cliente from cliente
join pedido on fecha_entrega>fecha_esperada;

-- 10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

select nombre_cliente, gama from cliente, pedido, producto, detalle_pedido
where cliente.codigo_cliente=pedido.codigo_pedido and pedido.codigo_pedido=detalle_pedido.codigo_pedido
and detalle_pedido.codigo_producto=producto.codigo_producto;

select nombre_cliente, gama from cliente
join pedido on cliente.codigo_cliente=pedido.codigo_pedido
join detalle_pedido on pedido.codigo_pedido=detalle_pedido.codigo_pedido
join producto on detalle_pedido.codigo_producto=producto.codigo_producto;
 















