/*Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.*/

	select nombre_cliente, count(p.codigo_cliente) as cant_pedidos
	from cliente c left join pedido p on p.codigo_cliente = c.codigo_cliente
	group by c.codigo_cliente;
	
	select c.nombre_cliente, (select count(codigo_cliente) from pedido p where c.codigo_cliente=p.codigo_cliente) as cant_ped
	from cliente c
	where c.codigo_cliente in
	(select p.codigo_cliente from pedido p where p.codigo_cliente=c.codigo_cliente) or 
	codigo_cliente not in(select p.codigo_cliente from pedido p where p.codigo_cliente=c.codigo_cliente);


/*Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.*/
	select nombre_cliente, (select coalesce(sum(total),'0') from pago pg where pg.codigo_cliente in(selec p.codigo_cliente from pedido p where p.codigo_cliente=c.codigo_cliente)) as total
	from cliente c 
	where c.codigo_cliente in
	(select p.codigo_cliente from pedido p where p.codigo_cliente in 
	(select pg.codigo_cliente from pago pg where pg.codigo_cliente=c.codigo_cliente)) or c.codigo_cliente not in
	(select p.codigo_cliente from pedido p where p.codigo_cliente not in
	(select pg.codigo_cliente from pago pg where pg.codigo_cliente=c.codigo_cliente));
    
/*Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.*/
    	select nombre_cliente
	from cliente c
	where c.codigo_cliente in
		(select p.codigo_cliente from pedido p where year(fecha_pedido) = '2008')
		order by nombre_cliente asc;

/*Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.*/
    	select nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.telefono
	from cliente c 
	left join empleado e on e.codigo_empleado = c.codigo_empleado_rep_ventas
	inner join oficina o on e.codigo_oficina = o.codigo_oficina 
	where c.codigo_cliente not in
				(select p.codigo_cliente from pago p);
    
/*Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.*/
	select nombre_cliente, 
	(select nombre from empleado e where c.codigo_empleado_rep_ventas=e.codigo_empleado) as rep,
	(select (select ciudad from oficina o where o.codigo_oficina=e.codigo_oficina) from empleado e 
	where c.codigo_empleado_rep_ventas=e.codigo_empleado) as ciudad_oficina
	from cliente c;

/*Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.*/
	select nombre, apellido1, apellido2, puesto,
	(select telefono from oficina o where e.codigo_oficina = o.codigo_oficina ) as telef_oficina
	from empleado e
	where codigo_empleado not in
		(select codigo_empleado_rep_ventas from cliente c);

/*Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene (cada una).*/
	select ciudad,
	(select count(*) from empleado e where o.codigo_oficina = e.codigo_oficina) 
	as empleado_por_oficina
	from oficina o;
	
