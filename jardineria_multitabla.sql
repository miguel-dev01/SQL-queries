/*Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.*/

select nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2
from cliente inner join empleado on cliente.codigo_empleado_rep_ventas = codigo_empleado;

/*Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.*/

select nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2
from cliente inner join empleado on cliente.codigo_empleado_rep_ventas = codigo_empleado
inner join pago on cliente.codigo_cliente = pago.codigo_cliente;

/*Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.*/

select distinct nombre_cliente, empleado.nombre
from cliente left join pago on cliente.codigo_cliente = pago.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = codigo_empleado
where pago.id_transaccion is null;

/*Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus 
representantes junto con la ciudad de la oficina a la que pertenece el representante.*/

select nombre_cliente, empleado.nombre, empleado.apellido1, empleado.apellido2, oficina.ciudad as ciudad_rep
from cliente inner join empleado on cliente.codigo_empleado_rep_ventas = codigo_empleado
inner join pago on cliente.codigo_cliente = pago.codigo_cliente
inner join oficina on oficina.codigo_oficina = empleado.codigo_oficina;

/*Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante.*/

select distinct nombre_cliente, empleado.nombre, oficina.ciudad
from cliente left join pago on cliente.codigo_cliente = pago.codigo_cliente
inner join empleado on cliente.codigo_empleado_rep_ventas = codigo_empleado
inner join oficina on oficina.codigo_oficina = empleado.codigo_oficina

/*Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.*/

select oficina.linea_direccion1, oficina.linea_direccion2
from oficina inner join empleado on oficina.codigo_oficina = empleado.codigo_oficina
inner join cliente on empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
where cliente.linea_direccion2 = 'Fuenlabrada' or cliente.ciudad = 'Fuenlabrada';

/*Devuelve el nombre de los clientes y el nombre de sus representantes 
junto con la ciudad de la oficina a la que pertenece el representante.*/

select cliente.nombre_cliente, empleado.nombre as nombre_rep, oficina.ciudad as ciudad_rep
from cliente inner join empleado on cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado
inner join oficina on oficina.codigo_oficina = empleado.codigo_oficina;

/*Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.*/

select t1.nombre as empleado, coalesce(t2.nombre,'') as jefe 
from empleado t1 left join empleado t2 on t1.codigo_jefe = t2.codigo_empleado;

/*Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y 
el nombre del jefe de sus jefe.*/

select t1.nombre as empleado, coalesce(t2.nombre,'') as jefe, coalesce(t3.nombre,'') as Jefe de jefe
from empleado t1 left join empleado t2 on t1.codigo_jefe = t2.codigo_empleado
left join empleado t3 on t2.codigo_jefe = t3.codigo_empleado;


select cliente.nombre
from cliente inner join pedido on cliente.codigo_cliente = pedido.codigo_cliente
where pedido.fecha_entrega > pedido.fecha_esperada;

/*Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.*/

select distinct gama_producto.gama, cliente.nombre_cliente
from gama_producto inner join producto on gama_producto.gama = producto.gama
inner join detalle_pedido on detalle_pedido.codigo_producto = producto.codigo_producto
inner join pedido on pedido.codigo_pedido = detalle_pedido.codigo_pedido
inner join cliente on cliente.codigo_cliente = pedido.codigo_pedido;

