USE gardendb;

CREATE TABLE gama_producto (
	id INT(7) AUTO_INCREMENT,
	descripcion_texto TEXT NULL,
	descripcion_html TEXT NULL,
	imagen VARCHAR(256) NULL,
	CONSTRAINT PK_GamaProducto_Id PRIMARY KEY(id)
);

CREATE TABLE pais (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Pais_Id PRIMARY KEY(id)
);

CREATE TABLE region (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Region_Id PRIMARY KEY(id)
);

CREATE TABLE ciudad (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	codigo_postal VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Ciudad_Id PRIMARY KEY(id)
);

CREATE TABLE puesto (
	id INT(7) AUTO_INCREMENT,
	puesto VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Puesto_Id PRIMARY KEY(id)
);

CREATE TABLE estado_pedido (
	id INT(7) AUTO_INCREMENT,
	estado VARCHAR(50) NOT NULL,
	CONSTRAINT PK_EstadoPedido_Id PRIMARY KEY(id)
);

CREATE TABLE tipo_pago (
	id INT(7) AUTO_INCREMENT,
	tipo VARCHAR(50) NOT NULL,
	CONSTRAINT PK_TipoPago_Id PRIMARY KEY(id)
);
CREATE TABLE tipo_telefono (
	id INT(7) AUTO_INCREMENT,
	tipo VARCHAR(50) NOT NULL,
	CONSTRAINT PK_TipoTelefono_Id PRIMARY KEY(id)
);

CREATE TABLE forma_pago (
	id INT(7) AUTO_INCREMENT,
	forma VARCHAR(50) NOT NULL,
	CONSTRAINT PK_FormaPago_Id PRIMARY KEY(id)
);

CREATE TABLE oficina (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50),
	CONSTRAINT PK_Oficina_Id PRIMARY KEY(id)
);

CREATE TABLE telefono_oficina (
	id INT(7) AUTO_INCREMENT,
	oficina_id INT(7),
	tipo_id INT(7),
	numero VARCHAR(50) UNIQUE,
	CONSTRAINT PK_TelefonoOficina_Id PRIMARY KEY(id),
	CONSTRAINT FK_TipoTelefono_TelefonoOficina_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id),
	CONSTRAINT FK_Oficina_TelefonoOficina_Id FOREIGN KEY(oficina_id) REFERENCES oficina(id)
);

CREATE TABLE direccion_oficina (
	id INT(7) AUTO_INCREMENT,
	oficina_id INT(7),
	pais_id INT(7),
	region_id INT(7),
	ciudad_id INT(7),
	detalle TEXT NOT NULL,
	CONSTRAINT PK_DireccionOficina_Id PRIMARY KEY(id),
	CONSTRAINT FK_Oficina_DireccionOficina_Id FOREIGN KEY(oficina_id) REFERENCES oficina(id),
	CONSTRAINT FK_Pais_DireccionOficina_Id FOREIGN KEY(pais_id) REFERENCES pais(id),
	CONSTRAINT FK_Region_DireccionOficina_Id FOREIGN KEY(region_id) REFERENCES region(id),
	CONSTRAINT FK_Ciudad_DireccionOficina_Id FOREIGN KEY(ciudad_id) REFERENCES ciudad(id)
);

CREATE TABLE empleado (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50) NOT NULL,
	extension VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	oficina_id INT(7),
	jefe_id INT(7) NULL,
	puesto_id INT(7),
	CONSTRAINT PK_Empleado_Id PRIMARY KEY(id),
	CONSTRAINT FK_Oficina_Empleado_Id FOREIGN KEY(oficina_id) REFERENCES oficina(id), 
	CONSTRAINT FK_Jefe_Empleado_Id FOREIGN KEY (jefe_id) REFERENCES empleado(id),
	CONSTRAINT FK_Puesto_Empleado_Id FOREIGN KEY(puesto_id) REFERENCES puesto(id)
);

CREATE TABLE contacto (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Contacto_Id PRIMARY KEY(id)
);

CREATE TABLE cliente (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	contacto_id INT(7),
	empleado_id INT(7),
	limite_credito DECIMAL(15,2) NULL,
	CONSTRAINT PK_Cliente_Id PRIMARY KEY(id),
	CONSTRAINT FK_Contacto_Cliente_Id FOREIGN KEY (contacto_id) REFERENCES contacto(id), 
	CONSTRAINT FK_Empleado_Cliente_Id FOREIGN KEY (empleado_id) REFERENCES empleado(id)
);

CREATE TABLE pago (
	id INT(7) AUTO_INCREMENT,
	cliente_id INT(7),
	forma_pago_id INT(7),
	tipo_pago_id INT(7),
	fecha_pago DATE NOT NULL,
	total DECIMAL (15,2) NOT NULL,
	CONSTRAINT PK_Transaccion_Id PRIMARY KEY(id),
	CONSTRAINT FK_Cliente_Pago_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id),
	CONSTRAINT FK_FormaPago_Pago_Id FOREIGN KEY (forma_pago_id) REFERENCES forma_pago(id),
	CONSTRAINT FK_TipoPago_Pago_Id FOREIGN KEY (tipo_pago_id) REFERENCES tipo_pago(id)
);

CREATE TABLE telefono_cliente (
	id INT(7) AUTO_INCREMENT,
	cliente_id INT(7),
	tipo_id INT(7),
	numero VARCHAR(50) UNIQUE,
	CONSTRAINT PK_TelefonoCliente_Id PRIMARY KEY(id),
	CONSTRAINT FK_Cliente_TelefonoCliente_Id FOREIGN KEY(cliente_id) REFERENCES cliente(id),
	CONSTRAINT FK_TipoTelefono_TelefonoCliente_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id)
);

CREATE TABLE direccion_cliente (
	id INT(7) AUTO_INCREMENT,
	cliente_id INT(7),
	pais_id INT(7),
	region_id INT(7),
	ciudad_id INT(7),
	detalle TEXT NOT NULL,
	CONSTRAINT PK_DireccionCliente_Id PRIMARY KEY(id),
	CONSTRAINT FK_Cliente_DireccionCliente_Id FOREIGN KEY(cliente_id) REFERENCES cliente(id),
	CONSTRAINT FK_Pais_DireccionCliente_Id FOREIGN KEY(pais_id) REFERENCES pais(id),
	CONSTRAINT FK_Region_DireccionCliente_Id FOREIGN KEY(region_id) REFERENCES region(id),
	CONSTRAINT FK_Ciudad_DireccionCliente_Id FOREIGN KEY(ciudad_id) REFERENCES ciudad(id)
);

CREATE TABLE producto (
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	gama_id INT(7),
	dimensiones VARCHAR(25) NULL,
	descripcion TEXT NULL,
	cantidad_en_stock SMALLINT(6) NOT NULL,
	CONSTRAINT PK_Producto_Id PRIMARY KEY(id),
	CONSTRAINT FK_GamaProducto_Producto_Id FOREIGN KEY(gama_id) REFERENCES gama_producto(id)
);

CREATE TABLE proveedor(
	id INT(7) AUTO_INCREMENT,
	nombre VARCHAR(70) NOT NULL,
	CONSTRAINT PK_Proveedor_Id PRIMARY KEY(id)
);

CREATE TABLE telefono_proveedor(
	id INT(7) AUTO_INCREMENT,
	proveedor_id INT(7),
	tipo_id INT(7),
	numero VARCHAR(50),
	CONSTRAINT PK_TelefonoProveedor_Id PRIMARY KEY(id),
	CONSTRAINT FK_proveedor_TelefonoProveedor_Id FOREIGN KEY(proveedor_id) REFERENCES proveedor(id),
	CONSTRAINT FK_TipoTelefono_TelefonoProveedor_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id)
);

CREATE TABLE direccion_proveedor (
	id INT(7) AUTO_INCREMENT,
	proveedor_id INT(7),
	pais_id INT(7),
	region_id INT(7),
	ciudad_id INT(7),
	detalle TEXT NOT NULL,
	CONSTRAINT PK_DireccionProveedor_Id PRIMARY KEY(id),
	CONSTRAINT FK_Proveedor_DireccionProveedor_Id FOREIGN KEY(proveedor_id) REFERENCES proveedor(id),
	CONSTRAINT FK_Pais_DireccionProveedor_Id FOREIGN KEY(pais_id) REFERENCES pais(id),
	CONSTRAINT FK_Region_DireccionProveedor_Id FOREIGN KEY(region_id) REFERENCES region(id),
	CONSTRAINT FK_Ciudad_DireccionProveedor_Id FOREIGN KEY(ciudad_id) REFERENCES ciudad(id)
);

CREATE TABLE precio (
	producto_id INT(7),
	precio_venta DECIMAL(15, 2) NOT NULL,
	proveedor_id INT(7),
	precio_proveedor DECIMAL(15, 2) NOT NULL,
	CONSTRAINT PK_precio_Id PRIMARY KEY(producto_id, proveedor_id),
	CONSTRAINT FK_Producto_Precio_Id FOREIGN KEY(producto_id) REFERENCES producto(id),
	CONSTRAINT FK_Proveedor_Precio_Id FOREIGN KEY(proveedor_id) REFERENCES proveedor(id)
);

CREATE TABLE pedido (
	id INT(7) AUTO_INCREMENT,
	fecha_pedido DATE NOT NULL,
	fecha_esperada DATE NOT NULL,
	fecha_entrega DATE NOT NULL,
	estado_pedido_id INT(7),
	cliente_id INT(7),
	pago_id INT(7),
	comentarios TEXT NULL,
	CONSTRAINT PK_Pedido_Id PRIMARY KEY(id),
	CONSTRAINT FK_EstadoPedido_Pedido_Id FOREIGN KEY (estado_pedido_id) REFERENCES estado_pedido(id),
	CONSTRAINT FK_Cliente_Pedido_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id),
	CONSTRAINT FK_Pago_Pedido_Id FOREIGN KEY (pago_id) REFERENCES pago(id)
);

CREATE TABLE detalle_pedido (
	producto_id INT(7),
	pedido_id INT(7),
	cantidad INT(10) NOT NULL,
	numero_linea SMALLINT(6) NOT NULL,
	CONSTRAINT PK_DetallePedido_Id PRIMARY KEY(producto_id, pedido_id),
	CONSTRAINT FK_Producto_Pedido_Id FOREIGN KEY (producto_id) REFERENCES producto(id),
	CONSTRAINT FK_Pedido_Pedido_Id FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);



INSERT INTO ciudad (nombre, codigo_postal) VALUES 
    ('Bilbao', '48001'),
    ('Barcelona', '08001'),
    ('Valencia', '46001'),
    ('Sevilla', '41001'),
    ('Madrid', '28001');
   
INSERT INTO pais (nombre) VALUES ('España');

INSERT INTO region (nombre) VALUES 
	('Norte'),
    ('Cataluña'),
    ('Comunidad Valenciana'),
    ('Andalucía'),
   	('Comunidad de Madrid');

INSERT INTO oficina (nombre) VALUES 
	('Oficina Principal Bilbao'),
    ('Oficina Principal Barcelona'),
    ('Oficina Principal Valencia'),
    ('Oficina Principal Sevilla'),
   	('Oficina Principal Madrid');
   
INSERT INTO direccion_oficina (oficina_id, pais_id, region_id, ciudad_id, detalle) VALUES
	(1, 1, 1, 1, 'Calle Gran Vía, 22, Bilbao'),
	(2, 1, 2, 2, 'Rambla de Catalunya, 100, Barcelona'),
	(3, 1, 3, 3, 'Calle Colón, 22, Valencia'),
	(4, 1, 4, 4, 'Calle Sierpes, 10, Sevilla'),
	(5, 1, 5, 5, 'Paseo de la Castellana, 50, Madrid');

INSERT INTO tipo_telefono (tipo) VALUES 
('Fijo'),
('Movil'),
('Fax');
   
INSERT INTO telefono_oficina (oficina_id, tipo_id, numero) VALUES
	(1, 1, '123456789'),
    (2, 1, '987654321'),
    (3, 1, '456123789'),
    (4, 1, '674985125'),
    (5, 1, '741252041');

#1.Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

SELECT DISTINCT 
	o.id AS codigo,
	c.nombre as ciudad
FROM 
	oficina o 
INNER JOIN 
	direccion_oficina do ON o.id = do.oficina_id  
INNER JOIN 
	ciudad c ON do.ciudad_id = c.id;

   
#2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT 
	c.nombre as nombre,
	tof.numero as telefono
FROM 
	oficina o
INNER JOIN
	direccion_oficina do ON o.id = do.oficina_id
INNER JOIN 	
	ciudad c ON c.id = do.ciudad_id 
INNER JOIN 
	telefono_oficina tof ON o.id = tof.oficina_id;

#3. Devuelve un listado con el nombre, apellidos 
# y email de los empleados cuyo jefe tiene un código de jefe igual a 7.