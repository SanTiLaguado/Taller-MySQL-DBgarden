# Taller GardenDB

**Consultas sobre una tabla**

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

```mysql
SELECT DISTINCT 
    -> o.id AS codigo,
    -> c.nombre as ciudad
    -> FROM 
    -> oficina o 
    -> INNER JOIN 
    -> direccion_oficina do ON o.id = do.oficina_id  
    -> INNER JOIN 
    -> ciudad c ON do.ciudad_id = c.id;
+--------+-----------+
| codigo | ciudad    |
+--------+-----------+
|      1 | Bilbao    |
|      2 | Barcelona |
|      3 | Valencia  |
|      4 | Sevilla   |
|      5 | Madrid    |
+--------+-----------+
```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

   ```mysql
   SELECT 
       -> c.nombre as nombre,
       -> tof.numero as telefono
       -> FROM 
       -> oficina o
       -> INNER JOIN
       -> direccion_oficina do ON o.id = do.oficina_id
       -> INNER JOIN 
       -> ciudad c ON c.id = do.ciudad_id 
       -> INNER JOIN 
       -> telefono_oficina tof ON o.id = tof.oficina_id;
   +-----------+-----------+
   | nombre    | telefono  |
   +-----------+-----------+
   | Bilbao    | 123456789 |
   | Barcelona | 987654321 |
   | Valencia  | 456123789 |
   | Sevilla   | 674985125 |
   | Madrid    | 741252041 |
   +-----------+-----------+
   ```

   

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
  jefe tiene un código de jefe igual a 7.

  ```mysql
  SELECT 
      -> e.nombre AS nombre,
      -> e.apellido1 AS apellido1,
      -> e.apellido2 AS apellido2,
      -> e.email AS email
      -> FROM
      -> empleado e
      -> WHERE e.jefe_id = 7;
  +--------+-----------+------------+---------------------------+
  | nombre | apellido1 | apellido2  | email                     |
  +--------+-----------+------------+---------------------------+
  | Lucía  | Ramírez   | Hernández  | lucia.ramirez@example.com |
  | Pedro  | Martín    | Ruiz       | pedro.martin@example.com  |
  | Marta  | Díaz      | Gómez      | marta.diaz@example.com    |
  +--------+-----------+------------+---------------------------+
  ```

  

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
  empresa.

  ```mysql
  SELECT 
      -> p.puesto AS puesto,
      -> e.nombre AS nombre,
      -> e.apellido1 AS apellido1,
      -> e.apellido2 AS apellido2,
      -> e.email AS email
      -> FROM 
      -> empleado e
      -> INNER JOIN
      -> puesto p
      -> ON
      -> p.id = e.puesto_id
      -> WHERE 
      -> e.puesto_id = 1;
  +---------+--------+-----------+-----------+------------------------+
  | puesto  | nombre | apellido1 | apellido2 | email                  |
  +---------+--------+-----------+-----------+------------------------+
  | Gerente | Juan   | Pérez     | García    | juan.perez@example.com |
  +---------+--------+-----------+-----------+------------------------+
  ```

  

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
  empleados que no sean representantes de ventas.

  ```mysql
  SELECT DISTINCT 
      -> e.nombre AS nombre,
      -> e.apellido1 AS apellido1,
      -> e.apellido2 AS apellido2,
      -> p.puesto AS puesto
      -> FROM 
      -> empleado e
      -> INNER JOIN
      -> puesto p
      -> ON
      -> p.id = e.puesto_id
      -> WHERE 
      -> e.puesto_id != 3;
  +--------+-----------+------------+------------+
  | nombre | apellido1 | apellido2  | puesto     |
  +--------+-----------+------------+------------+
  | Juan   | Pérez     | García     | Gerente    |
  | Ana    | López     | Martínez   | Asistente  |
  | Elena  | Torres    | Jiménez    | Asistente  |
  | María  | González  | Rodríguez  | Secretario |
  | Pedro  | Martín    | Ruiz       | Secretario |
  | Lucía  | Ramírez   | Hernández  | Analista   |
  +--------+-----------+------------+------------+
  ```

  

6. Devuelve un listado con el nombre de los todos los clientes españoles.

   ```mysql
   SELECT 
       -> c.nombre
       -> FROM 
       -> cliente c
       -> JOIN 
       -> direccion_cliente dc
       -> ON
       -> c.id = dc.cliente_id
       -> WHERE
       -> dc.pais_id = 1;
   +---------------------+
   | nombre              |
   +---------------------+
   | Floristeria Mirazur |
   | Flores los tamales  |
   | Flores el arrecho   |
   +---------------------+
   ```

   

7. Devuelve un listado con los distintos estados por los que puede pasar un
  pedido.

  ```mysql
  SELECT * FROM estado_pedido ep;
  +----+------------------------------+
  | id | estado                       |
  +----+------------------------------+
  |  1 | En proceso de preparación    |
  |  2 | En espera de pago            |
  |  3 | Pagado y en espera de envío  |
  |  4 | Enviado                      |
  |  5 | Entregado                    |
  |  6 | Cancelado                    |
  +----+------------------------------+
  ```

  

8. Devuelve un listado con el código de cliente de aquellos clientes que
  realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
  aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:


  • Utilizando la función YEAR de MySQL.

  ```mysql
  SELECT DISTINCT 
      -> c.id AS codigo
      -> FROM 
      -> cliente c
      -> JOIN
      -> pago p
      -> ON
      -> c.id = p.cliente_id
      -> WHERE YEAR(p.fecha_pago) = 2008;
  +--------+
  | codigo |
  +--------+
  |      1 |
  |      2 |
  |      3 |
  +--------+
  ```


  • Utilizando la función DATE_FORMAT de MySQL.

  ```mysql
  SELECT DISTINCT 
      -> c.id AS codigo
      -> FROM 
      -> cliente c
      -> JOIN
      -> pago p
      -> ON
      -> c.id = p.cliente_id
      -> WHERE DATE_FORMAT(p.fecha_pago , "%Y") = '2008';
  +--------+
  | codigo |
  +--------+
  |      1 |
  |      2 |
  |      3 |
  +--------+
  ```


  • Sin utilizar ninguna de las funciones anteriores.

  ```mysql
  SELECT DISTINCT 
      -> c.id AS codigo
      -> FROM 
      -> cliente c
      -> JOIN
      -> pago p
      -> ON
      -> c.id = p.cliente_id
      -> WHERE p.fecha_pago >= '2008-01-01' AND p.fecha_pago <= '2008-12-31';
  +--------+
  | codigo |
  +--------+
  |      1 |
  |      3 |
  |      2 |
  +--------+
  ```

  

9. Devuelve un listado con el código de pedido, código de cliente, fecha
  esperada y fecha de entrega de los pedidos que no han sido entregados a
  tiempo.

  ```mysql
  SELECT 
      -> p.id as CODIGO,
      -> c.id as CLIENTE,
      -> p.fecha_esperada as FechaEsp,
      -> p.fecha_entrega as FechaEnt
      -> FROM
      -> pedido p
      -> JOIN
      -> cliente c
      -> ON
      -> c.id = p.cliente_id
      -> WHERE
      -> DATE(p.fecha_esperada) < DATE(p.fecha_entrega);
  +--------+---------+------------+------------+
  | CODIGO | CLIENTE | FechaEsp   | FechaEnt   |
  +--------+---------+------------+------------+
  |      1 |       1 | 2005-01-16 | 2005-01-17 |
  |      4 |       1 | 2008-05-01 | 2008-05-02 |
  |      7 |       1 | 2011-07-16 | 2011-07-17 |
  |     10 |       1 | 2014-10-31 | 2014-11-02 |
  |     13 |       1 | 2006-01-16 | 2006-01-18 |
  |     16 |       1 | 2009-05-01 | 2009-05-04 |
  |     19 |       1 | 2012-07-16 | 2012-07-18 |
  |     24 |       1 | 2005-01-16 | 2005-01-17 |
  |     25 |       1 | 2005-01-16 | 2005-01-17 |
  |      5 |       2 | 2009-05-06 | 2009-05-08 |
  |      8 |       2 | 2012-08-21 | 2012-08-22 |
  |     11 |       2 | 2015-11-06 | 2015-11-09 |
  |     14 |       2 | 2007-02-21 | 2007-02-23 |
  |     17 |       2 | 2010-05-06 | 2010-05-07 |
  |     20 |       2 | 2013-08-21 | 2013-08-24 |
  |     22 |       2 | 2005-01-16 | 2005-01-17 |
  |      3 |       3 | 2007-03-26 | 2007-03-28 |
  |      6 |       3 | 2010-06-11 | 2010-06-14 |
  |      9 |       3 | 2013-09-26 | 2013-09-28 |
  |     12 |       3 | 2005-12-11 | 2005-12-13 |
  |     15 |       3 | 2008-03-26 | 2008-03-29 |
  |     18 |       3 | 2011-06-11 | 2011-06-13 |
  |     21 |       3 | 2005-01-16 | 2005-01-17 |
  |     23 |       3 | 2005-01-16 | 2005-01-17 |
  +--------+---------+------------+------------+
  ```

  

10. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
    menos dos días antes de la fecha esperada.


    • Utilizando la función ADDDATE de MySQL.

    ```mysql
    SELECT 
    	p.id as CODIGO,
    	c.id as CLIENTE,
    	p.fecha_esperada as FechaEsp,
    	p.fecha_entrega as FechaEnt
    FROM
    	pedido p
    JOIN
    	cliente c
    ON
    	c.id = p.cliente_id
    WHERE 
    	p.fecha_entrega <= ADDDATE(p.fecha_esperada, INTERVAL -2 DAY);
    ```


    • Utilizando la función DATEDIFF de MySQL.

    ```mysql
    SELECT 
        p.id AS CODIGO,
        c.id AS CLIENTE,
        p.fecha_esperada AS FechaEsp,
        p.fecha_entrega AS FechaEnt
    FROM
        pedido p
    JOIN
        cliente c ON c.id = p.cliente_id
    WHERE 
        DATEDIFF(p.fecha_esperada, p.fecha_entrega) >= 2;
    ```


    • ¿Sería posible resolver esta consulta utilizando el operador de suma + o
    resta -?

    ```mysql
    SELECT 
        p.id AS CODIGO,
        c.id AS CLIENTE,
        p.fecha_esperada AS FechaEsp,
        p.fecha_entrega AS FechaEnt
    FROM
        pedido p
    JOIN
        cliente c ON c.id = p.cliente_id
    WHERE 
        p.fecha_entrega <= p.fecha_esperada - 2;
    ```


    

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

    ```mysql
    SELECT * FROM
        -> pedido p
        -> WHERE
        -> p.estado_pedido_id = 6 AND YEAR(p.fecha_pedido) = '2009';
    +----+--------------+----------------+---------------+------------------+------------+---------+-------------+
    | id | fecha_pedido | fecha_esperada | fecha_entrega | estado_pedido_id | cliente_id | pago_id | comentarios |
    +----+--------------+----------------+---------------+------------------+------------+---------+-------------+
    | 25 | 2009-03-08   | 2009-03-09     | 2009-03-09    |                6 |          1 |    NULL |             |
    +----+--------------+----------------+---------------+------------------+------------+---------+-------------+
    
    ```

    

12. Devuelve un listado de todos los pedidos que han sido entregados en el
    mes de enero de cualquier año.

    ```mysql
    SELECT * FROM
        -> pedido p 
        -> WHERE
        -> p.estado_pedido_id = 5 AND MONTH(p.fecha_entrega) = '01';
    +----+--------------+----------------+---------------+------------------+------------+---------+------------------------------------------------------+
    | id | fecha_pedido | fecha_esperada | fecha_entrega | estado_pedido_id | cliente_id | pago_id | comentarios                                          |
    +----+--------------+----------------+---------------+------------------+------------+---------+------------------------------------------------------+
    |  1 | 2005-01-15   | 2005-01-16     | 2005-01-17    |                5 |          1 |       1 | Pedido urgente, por favor entregar lo antes posible. |
    | 13 | 2006-01-15   | 2006-01-16     | 2006-01-18    |                5 |          1 |      13 | Entrega programada para el fin de semana.            |
    | 21 | 2008-06-25   | 2005-01-16     | 2005-01-17    |                5 |          3 |      21 | Pedido urgente, por favor entregar lo antes posible. |
    | 22 | 2008-12-21   | 2005-01-16     | 2005-01-17    |                5 |          2 |      22 | Pedido urgente, por favor entregar lo antes posible. |
    | 23 | 2008-12-10   | 2005-01-16     | 2005-01-17    |                5 |          3 |      23 | Favor llamar antes de la entrega.                    |
    | 24 | 2008-07-05   | 2005-01-16     | 2005-01-17    |                5 |          1 |      24 | Pedido urgente, por favor entregar lo antes posible. |
    +----+--------------+----------------+---------------+------------------+------------+---------+------------------------------------------------------+
    ```

    
13. Devuelve un listado con todos los pagos que se realizaron en el
    año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

    ```mysql
    SELECT * FROM
        -> pago p
        -> WHERE
        -> p.forma_pago_id = 4 AND YEAR(p.fecha_pago) = 2008
        -> ORDER BY p.fecha_pago DESC;
    +----+------------+---------------+--------------+------------+---------+
    | id | cliente_id | forma_pago_id | tipo_pago_id | fecha_pago | total   |
    +----+------------+---------------+--------------+------------+---------+
    | 24 |          3 |             4 |            1 | 2008-12-10 |  900.00 |
    | 23 |          2 |             4 |            1 | 2008-09-21 | 2000.00 |
    | 22 |          1 |             4 |            1 | 2008-07-05 | 1500.00 |
    | 21 |          3 |             4 |            1 | 2008-06-25 | 2600.00 |
    | 25 |          1 |             4 |            1 | 2008-03-08 | 3100.00 |
    +----+------------+---------------+--------------+------------+---------+
    ```

    
14. Devuelve un listado con todas las formas de pago que aparecen en la
    tabla pago. Tenga en cuenta que no deben aparecer formas de pago
    repetidas.

    ```mysql
    SELECT DISTINCT 
        -> p.forma_pago_id AS ID,
        -> fp.forma AS FORMA
        -> FROM
        -> pago p
        -> JOIN
        -> forma_pago fp 
        -> ON
        -> p.forma_pago_id = fp.id; 
    +------+------------------------+
    | ID   | FORMA                  |
    +------+------------------------+
    |    1 | Tarjeta de Crédito     |
    |    2 | Transferencia Bancaria |
    |    3 | Cheque                 |
    |    4 | PayPal                 |
    +------+------------------------+
    ```

    
15. Devuelve un listado con todos los productos que pertenecen a la
    gama Ornamentales y que tienen más de 100 unidades en stock. El listado
    deberá estar ordenado por su precio de venta, mostrando en primer lugar
    los de mayor precio.

    ```mysql
    SELECT * FROM
        -> producto p
        -> WHERE
        -> p.gama_id = 1 AND p.cantidad_en_stock >= 100; 
    +----+------------------+---------+-------------+-------------------------------------------------------+-------------------+
    | id | nombre                             | gama_id | dimensiones | descripcion                 | cantidad_en_stock |
    +----+------------------+---------+-------------+-------------------------------------------------------+-------------------+
    |  2 | Maceta de Cerámica Pintada a Mano  |       1 | 30x30 cm    | Maceta de cerámica pintada  |               180 |
    +----+------------------------------------+---------+-------------+-------------------------------------+-------------------+
    
    ```

    
16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
    cuyo representante de ventas tenga el código de empleado 11 o 30.

    ```mysql
    SELECT * FROM
        ->     cliente c 
        -> JOIN
        ->     direccion_cliente dc
        -> ON
        ->     c.id = dc.cliente_id
        -> WHERE
        ->     dc.ciudad_id = 5
        -> AND
        ->     (c.empleado_id = 11 OR c.empleado_id = 30);
    Empty set (0,01 sec)
    ```

**Consultas multitabla (Composición interna)**

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con
sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.



1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
  representante de ventas.

  ```mysql
  SELECT 
      -> c.nombre AS "NOMBRE CLIENTE",
      -> e.nombre AS "NOMBRE REP. VTAS"
      -> FROM 
      -> cliente c
      -> INNER JOIN
      -> empleado e
      -> ON
      -> c.empleado_id = e.id;
  +---------------------+------------------+
  | NOMBRE CLIENTE      | NOMBRE REP. VTAS |
  +---------------------+------------------+
  | Floristeria Mirazur | Ana              |
  | Flores los tamales  | Carlos           |
  | Flores el arrecho   | María            |
  +---------------------+------------------+
  
  ```

  

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
  nombre de sus representantes de ventas.

  ```mysql
  SELECT DISTINCT 
      -> p.id AS "COD PAGO",
      -> c.nombre AS "NOMBRE CLIENTE",
      -> e.nombre AS "NOMBRE REP. VTAS"
      -> FROM 
      -> cliente c
      -> INNER JOIN
      -> empleado e ON
      -> c.empleado_id = e.id
      -> INNER JOIN
      -> pago p ON
      -> c.id = p.cliente_id
      -> ORDER BY p.id ASC;
  +----------+---------------------+------------------+
  | COD PAGO | NOMBRE CLIENTE      | NOMBRE REP. VTAS |
  +----------+---------------------+------------------+
  |        1 | Floristeria Mirazur | Ana              |
  |        2 | Flores los tamales  | Carlos           |
  |        3 | Flores el arrecho   | María            |
  |        4 | Floristeria Mirazur | Ana              |
  |        5 | Flores los tamales  | Carlos           |
  |        6 | Flores el arrecho   | María            |
  |        7 | Floristeria Mirazur | Ana              |
  |        8 | Flores los tamales  | Carlos           |
  |        9 | Flores el arrecho   | María            |
  |       10 | Floristeria Mirazur | Ana              |
  |       11 | Flores los tamales  | Carlos           |
  |       12 | Flores el arrecho   | María            |
  |       13 | Floristeria Mirazur | Ana              |
  |       14 | Flores los tamales  | Carlos           |
  |       15 | Flores el arrecho   | María            |
  |       16 | Floristeria Mirazur | Ana              |
  |       17 | Flores los tamales  | Carlos           |
  |       18 | Flores el arrecho   | María            |
  |       19 | Floristeria Mirazur | Ana              |
  |       20 | Flores los tamales  | Carlos           |
  |       21 | Flores el arrecho   | María            |
  |       22 | Floristeria Mirazur | Ana              |
  |       23 | Flores los tamales  | Carlos           |
  |       24 | Flores el arrecho   | María            |
  |       25 | Floristeria Mirazur | Ana              |
  +----------+---------------------+------------------+
  
  ```

  

3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
  el nombre de sus representantes de ventas.

  ```mysql
  SELECT DISTINCT 
      -> c.nombre AS "NOMBRE CLIENTE",
      -> e.nombre AS "NOMBRE REP. VTAS"
      -> FROM 
      -> cliente c
      -> INNER JOIN
      -> empleado e ON c.empleado_id = e.id
      -> LEFT JOIN
      -> pago p ON c.id = p.cliente_id
      -> WHERE
      -> p.cliente_id IS NULL;
  +------------------+------------------+
  | NOMBRE CLIENTE   | NOMBRE REP. VTAS |
  +------------------+------------------+
  | regalos el catre | María            |
  +------------------+------------------+
  
  ```

  

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
  representantes junto con la ciudad de la oficina a la que pertenece el
  representante.

  ```mysql
  SELECT DISTINCT 
      -> c.nombre AS "NOMBRE CLIENTE",
      -> e.nombre AS "NOMBRE REP. VTAS",
      -> c2.nombre AS "CIUDAD OFC. REP."
      -> FROM 
      -> cliente c
      -> INNER JOIN
      -> empleado e ON c.empleado_id = e.id
      -> INNER JOIN
      -> oficina o ON e.oficina_id = o.id
      -> INNER JOIN
      -> direccion_oficina do ON o.id = do.oficina_id
      -> INNER JOIN
      -> ciudad c2 ON do.ciudad_id = c2.id;
  +---------------------+------------------+------------------+
  | NOMBRE CLIENTE      | NOMBRE REP. VTAS | CIUDAD OFC. REP. |
  +---------------------+------------------+------------------+
  | Floristeria Mirazur | Ana              | Barcelona        |
  | Flores los tamales  | Carlos           | Valencia         |
  | Flores el arrecho   | María            | Sevilla          |
  | regalos el catre    | María            | Sevilla          |
  +---------------------+------------------+------------------+
  
  ```

  

5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
  de sus representantes junto con la ciudad de la oficina a la que pertenece el
  representante.

  ```mysql
  SELECT 
      ->     c.nombre AS "NOMBRE CLIENTE", 
      ->     e.nombre AS "NOMBRE REP. VTAS", 
      ->     ci.nombre AS "CIUDAD OFC. REP."
      -> FROM 
      ->     cliente c
      -> INNER JOIN 
      ->     empleado e ON c.empleado_id = e.id
      -> INNER JOIN 
      ->     oficina o ON e.oficina_id = o.id
      -> INNER JOIN 
      ->     direccion_oficina do ON o.id = do.oficina_id
      -> INNER JOIN 
      ->     ciudad ci ON do.ciudad_id = ci.id
      -> WHERE 
      ->     c.id NOT IN (SELECT cliente_id FROM pago);
  +------------------+------------------+------------------+
  | NOMBRE CLIENTE   | NOMBRE REP. VTAS | CIUDAD OFC. REP. |
  +------------------+------------------+------------------+
  | regalos el catre | María            | Sevilla          |
  +------------------+------------------+------------------+
  ```



6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
con la ciudad de la oficina a la que pertenece el representante.

8. Devuelve un listado con el nombre de los empleados junto con el nombre
de sus jefes.
9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
de su jefe y el nombre del jefe de sus jefe.
10. Devuelve el nombre de los clientes a los que no se les ha entregado a
tiempo un pedido.
11. Devuelve un listado de las diferentes gamas de producto que ha comprado
cada cliente.

