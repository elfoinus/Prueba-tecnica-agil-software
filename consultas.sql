
-- 1
SELECT c.Identificacion,CONCAT(c.Nombres," ",c.Apellidos) as nombre_completo, SUM(co.Valor) Total_compras,COUNT(co.Valor) cantidad_compras, YEAR(co.Fecha)  as año
from cliente c 
inner join  compra co on c.IdCliente = co.idCliente
GROUP BY YEAR(co.Fecha)

-- 2
SELECT e.Nombres,e.Apellidos,COUNT(c.IdCompraLibro) as TotalLibros from empleado e 
inner join compra c on c.IdEmpleado = e.IdEmpleado
GROUP BY e.IdEmpleado

-- 3 
DELIMITER //
CREATE PROCEDURE ventas_por_empleado(IN ano YEAR)
BEGIN
(    
    SELECT  e.Nombres as NombreCompleto, SUM(c.Valor) as ValorTotalVentas
    from empleado e 
    inner join compra c on c.IdEmpleado = e.IdEmpleado
    where YEAR(c.Fecha) = ano 
    GROUP BY e.IdEmpleado
    ORDER BY SUM(c.Valor) desc
)  
UNION 
(
	SELECT  e.Nombres as NombreCompleto, 0 as ValorTotalVentas
    from empleado e 
    inner join compra c on c.IdEmpleado = e.IdEmpleado
    WHERE
    YEAR(c.Fecha) <> ano AND e.IdEmpleado not in
    (
        SELECT  e.IdEmpleado
        from empleado e 
        inner join compra c on c.IdEmpleado = e.IdEmpleado
        where YEAR(c.Fecha) = ano 
        GROUP BY e.IdEmpleado
        ORDER BY SUM(c.Valor) desc
    )
    GROUP BY e.IdEmpleado
    ORDER BY SUM(c.Valor) desc
);
END //

DELIMITER ;

CALL ventas_por_empleado(año)
-- 4 

SELECT   c.Identificacion,concat(c.Nombres," ",c.Apellidos) as NombreCompleto, e.Nombre as EditorialFavorita
from cliente c 
INNER join compra co on c.IdCliente = co.idCliente
inner join libro l on co.IdLibro = l.IdLibro
inner join editorial e on l.IdEditorial = e.IdEditorial
WHERE c.IdCliente = 1 -- cambiar id por la del cliente o ¿buscar por identificacion?
 GROUP BY e.IdEditorial
 ORDER BY COUNT( e.IdEditorial) desc
 limit 1


-- 5

SELECT DISTINCT c.* from cliente c
inner join compra co on c.IdCliente = co.idCliente 
WHERE YEAR(co.Fecha) <> 2019 AND c.Email  LIKE '%gmail%'

union  -- para incluir los que no han comprado 

SELECT DISTINCT c.* from cliente c
WHERE  c.Email  LIKE '%gmail%' AND 
c.IdCliente not in (select IdCliente from compra)