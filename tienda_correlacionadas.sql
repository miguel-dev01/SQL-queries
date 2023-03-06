/*Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.*/
	select nombre, precio, (select nombre from fabricante f where p.id_fabricante = f.id) as fabri
	from producto p
	where precio >= all(select precio from producto p2 where p2.id_fabricante=p.id_fabricante);


/*Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.*/
	select * 
	from producto
	where precio >= all(select avg(precio) from producto p2 where p2.id_fabricante = 
		(select id from fabricante f where p2.id_fabricante = f.id));
	
   
   
/*Lista el nombre del producto más caro del fabricante Lenovo.*/
    	select nombre 
	from producto 
	where precio >= all(select precio from producto where id_fabricante = (
			select id from fabricante where nombre = 'Lenovo')) and id_fabricante = 
			(select id from fabricante where nombre = 'Lenovo');

