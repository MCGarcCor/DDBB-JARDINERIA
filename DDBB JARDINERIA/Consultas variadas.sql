

-- 1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. 
-- Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
select nombre_cliente, count(codigo_pedido) as Total_Pedidos from cliente
left join pedido on cliente.codigo_cliente=pedido.codigo_cliente
group by nombre_cliente;

-- 2. Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. 
-- Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
select nombre_cliente, sum(total) as Total_Pagado from cliente
join pago on pago.codigo_cliente = cliente.codigo_cliente
group by nombre_cliente;

-- 3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
select nombre_cliente from cliente
join pedido on cliente.codigo_cliente=pedido.codigo_cliente
where extract(year from fecha_pedido)=2008
group by nombre_cliente
order by nombre_cliente asc;

-- 4. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y 
-- el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.

select nombre_cliente, em.nombre, em.apellido1, oficina.telefono from cliente
join empleado em on codigo_empleado=codigo_empleado_rep_ventas
join oficina on em.codigo_oficina=oficina.codigo_oficina
where codigo_cliente not in (select codigo_cliente from pago);

-- 5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su 
-- representante de ventas y la ciudad donde está su oficina.
select nombre_cliente, em.nombre, em.apellido1, oficina.ciudad from cliente
join empleado em on codigo_empleado=codigo_empleado_rep_ventas
join oficina on em.codigo_oficina=oficina.codigo_oficina;

-- 6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante 
-- de ventas de ningún cliente.

select em.nombre, em.apellido1, em.apellido2, puesto, oficina.telefono from empleado em
join oficina on em.codigo_oficina=oficina.codigo_oficina
where em.codigo_empleado not in (select codigo_empleado_rep_ventas from cliente
					join empleado on codigo_empleado=codigo_empleado_rep_ventas);

-- 7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
select ciudad, count(codigo_empleado) as Num_Empleados from oficina
join empleado on empleado.codigo_oficina=oficina.codigo_oficina
group by ciudad;






