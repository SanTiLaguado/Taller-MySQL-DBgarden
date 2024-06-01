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
   

INSERT INTO puesto (puesto) VALUES 
    ('Gerente'),
    ('Asistente'),
    ('Representante de ventas'),
    ('Secretario'),
    ('Analista');


-- Insertar empleados sin jefe (jefes principales)
INSERT INTO empleado (id, nombre, apellido1, apellido2, extension, email, oficina_id, jefe_id, puesto_id) VALUES 
    (1, 'Juan', 'Pérez', 'García', '101', 'juan.perez@example.com', 1, NULL, 1), -- jefe sin jefe
    (7, 'Elena', 'Torres', 'Jiménez', '107', 'elena.torres@example.com', 2, NULL, 2); -- jefe sin jefe

    
-- Insertar empleados con jefe
INSERT INTO empleado (id, nombre, apellido1, apellido2, extension, email, oficina_id, jefe_id, puesto_id) VALUES 
    (2, 'Ana', 'López', 'Martínez', '102', 'ana.lopez@example.com', 2, 1, 2), -- jefe es Juan con ID 1
    (3, 'Carlos', 'Sánchez', 'Fernández', '103', 'carlos.sanchez@example.com', 3, 1, 3), -- jefe es Juan con ID 1
    (4, 'María', 'González', 'Rodríguez', '104', 'maria.gonzalez@example.com', 4, 1, 4), -- jefe es Juan con ID 1
    (5, 'Lucía', 'Ramírez', 'Hernández', '105', 'lucia.ramirez@example.com', 5, 7, 5), -- jefe es Elena con ID 7
    (6, 'Pedro', 'Martín', 'Ruiz', '106', 'pedro.martin@example.com', 1, 7, 4), -- jefe es Elena con ID 7
    (8, 'Marta', 'Díaz', 'Gómez', '108', 'marta.diaz@example.com', 3, 7, 3); -- jefe es Elena con ID 7


INSERT INTO contacto (id, nombre, apellido, email) VALUES
    (1, 'Laura', 'Gómez', 'laura.gomez@example.com'),
    (2, 'Roberto', 'Díaz', 'roberto.diaz@example.com'),
    (3, 'Sofía', 'Martínez', 'sofia.martinez@example.com');

INSERT INTO cliente (id, nombre, contacto_id, empleado_id, limite_credito) VALUES
    (1, 'Floristeria Mirazur', 1, 2, 5000.00),
    (2, 'Flores los tamales', 2, 3, 7000.00),
    (3, 'Flores el arrecho', 3, 4, 10000.00),
    (4, 'regalos el catre', 3, 4, 9000.00);
   
INSERT INTO direccion_cliente (id, cliente_id, pais_id, region_id, ciudad_id, detalle) VALUES
    (1, 1, 1, 1, 1, 'Calle Falsa, 123, Bilbao'),
    (2, 2, 1, 2, 2, 'Avenida Siempre Viva, 742, Barcelona'),
    (3, 3, 1, 3, 3, 'Calle del Río, 456, Valencia'),
    (4, 4, 1, 3, 3, 'Calle del cucurucho, 56, Valencia');
   
INSERT INTO estado_pedido (estado) VALUES 
    ('En proceso de preparación'),
    ('En espera de pago'),
    ('Pagado y en espera de envío'),
    ('Enviado'),
    ('Entregado'),
    ('Cancelado');
   
INSERT INTO forma_pago (forma) VALUES
    ('Tarjeta de Crédito'),
    ('Transferencia Bancaria'),
    ('Cheque'),
   	('PayPal');

INSERT INTO tipo_pago (tipo) VALUES
    ('Pago de contado'),
    ('Pago a credito');
   
INSERT INTO pago (cliente_id, forma_pago_id, tipo_pago_id, fecha_pago, total) VALUES
    (1, 1, 1, '2005-01-15', 1000.00),
    (2, 2, 2, '2006-02-20', 1500.00),
    (3, 2, 1, '2007-03-25', 1200.00),
    (1, 3, 2, '2008-04-30', 800.00),
    (2, 1, 1, '2009-05-05', 2000.00),
    (3, 2, 2, '2010-06-10', 900.00),
    (1, 2, 1, '2011-07-15', 1800.00),
    (2, 1, 2, '2012-08-20', 1600.00),
    (3, 2, 1, '2013-09-25', 1300.00),
    (1, 1, 2, '2014-10-30', 1100.00),
    (2, 2, 1, '2015-11-05', 1900.00),
    (3, 2, 2, '2005-12-10', 1700.00),
    (1, 2, 1, '2006-01-15', 1000.00),
    (2, 2, 2, '2007-02-20', 1500.00),
    (3, 3, 1, '2008-03-25', 1200.00),
    (1, 1, 2, '2009-04-30', 800.00),
    (2, 2, 1, '2010-05-05', 2000.00),
    (3, 3, 2, '2011-06-10', 900.00),
    (1, 3, 1, '2012-07-15', 1800.00),
    (2, 2, 2, '2013-08-20', 1600.00),
   	(3, 4, 1, '2008-06-25', 2600.00),
	(2, 4, 1, '2008-09-21', 2000.00),
	(3, 4, 1, '2008-12-10', 900.00),
	(1, 4, 1, '2008-07-05', 1500.00),
	(1, 4, 1, '2008-03-08', 3100.00);
   

INSERT INTO pedido (id, fecha_pedido, fecha_esperada, fecha_entrega, estado_pedido_id, cliente_id, pago_id, comentarios) VALUES
    (1, '2005-01-15', '2005-01-16', '2005-01-17', 5, 1, 1, 'Pedido urgente, por favor entregar lo antes posible.'),
    (2, '2006-02-20', '2006-02-21', '2006-02-21', 5, 2, 2, 'Cliente prefiere contacto telefónico antes de la entrega.'),
    (3, '2007-03-25', '2007-03-26', '2007-03-28', 5, 3, 3, 'Dirección de entrega actualizada.'),
    (4, '2008-04-30', '2008-05-01', '2008-05-02', 5, 1, 4, 'Producto dañado en tránsito, necesito un reemplazo.'),
    (5, '2009-05-05', '2009-05-06', '2009-05-08', 5, 2, 5, 'Favor entregar después de las 5 PM.'),
    (6, '2010-06-10', '2010-06-11', '2010-06-14', 5, 3, 6, 'Pedido de regalo, incluir envoltura especial.'),
    (7, '2011-07-15', '2011-07-16', '2011-07-17', 5, 1, 7, 'Confirme la disponibilidad antes de la entrega.'),
    (8, '2012-08-20', '2012-08-21', '2012-08-22', 5, 2, 8, 'Necesito una factura con IVA.'),
    (9, '2013-09-25', '2013-09-26', '2013-09-28', 5, 3, 9, 'Cambiar la dirección de entrega.'),
    (10, '2014-10-30', '2014-10-31', '2014-11-02', 5, 1, 10, 'Favor llamar antes de la entrega.'),
    (11, '2015-11-05', '2015-11-06', '2015-11-09', 5, 2, 11, 'Entregar en la oficina en lugar de la casa.'),
    (12, '2005-12-10', '2005-12-11', '2005-12-13', 5, 3, 12, 'Por favor, no llamar antes de las 10 AM.'),
    (13, '2006-01-15', '2006-01-16', '2006-01-18', 5, 1, 13, 'Entrega programada para el fin de semana.'),
    (14, '2007-02-20', '2007-02-21', '2007-02-23', 5, 2, 14, 'Entregar en la puerta trasera.'),
    (15, '2008-03-25', '2008-03-26', '2008-03-29', 5, 3, 15, 'Producto adicional agregado al pedido.'),
    (16, '2009-04-30', '2009-05-01', '2009-05-04', 5, 1, 16, 'Por favor, entregar antes del día festivo.'),
    (17, '2010-05-05', '2010-05-06', '2010-05-07', 5, 2, 17, 'Entregar en la portería.'),
    (18, '2011-06-10', '2011-06-11', '2011-06-13', 5, 3, 18, 'Entregar en la oficina de recepción.'),
    (19, '2012-07-15', '2012-07-16', '2012-07-18', 5, 1, 19, 'Cliente ausente en la fecha de entrega anterior.'),
    (20, '2013-08-20', '2013-08-21', '2013-08-24', 5, 2, 20, 'Entregar después de las 6 PM.'),
    (21, '2008-06-25', '2005-01-16', '2005-01-17', 5, 3, 21, 'Pedido urgente, por favor entregar lo antes posible.'),
    (22, '2008-12-21', '2005-01-16', '2005-01-17', 5, 2, 22, 'Pedido urgente, por favor entregar lo antes posible.'),
    (23, '2008-12-10', '2005-01-16', '2005-01-17', 5, 3, 23, 'Favor llamar antes de la entrega.'),
    (24, '2008-07-05', '2005-01-16', '2005-01-17', 5, 1, 24, 'Pedido urgente, por favor entregar lo antes posible.'),
    (25, '2008-03-08', '2005-01-16', '2005-01-17', 5, 1, 25, 'Cliente prefiere contacto telefónico antes de la entrega.');

INSERT INTO proveedor (nombre) VALUES
    ('Proveedor LA TATACOA'),
    ('Proveedor BUENAVENTURA'),
    ('Proveedor CASA ASTRA'),
    ('Proveedor DONDE CHUNGA'),
    ('Proveedor EL PERRON'),
    ('Proveedor FARRAS');
   
INSERT INTO telefono_proveedor (proveedor_id, tipo_id, numero) VALUES
    (1, 1, '872145698'),
    (2, 1, '685471524'),
    (3, 2, '456123789'),
    (4, 2, '658725841'),
    (5, 1, '741252041'),
    (6, 1, '369852147');
  
INSERT INTO direccion_proveedor (proveedor_id, pais_id, region_id, ciudad_id, detalle) VALUES
    (1, 1, 1, 1, 'Calle Proveedor A, 123, Bilbao'),
    (2, 1, 2, 2, 'Avenida Proveedor B, 456, Barcelona'),
    (3, 1, 3, 3, 'Plaza Proveedor C, 789, Valencia'),
    (4, 1, 4, 4, 'Calle Proveedor D, 101, Ciudad D'),
    (5, 1, 5, 5, 'Avenida Proveedor E, 111, Sevilla'),
    (6, 1, 1, 1, 'Calle Proveedor F, 222, Madrid');
   
INSERT INTO gama_producto (descripcion_texto, descripcion_html, imagen) VALUES 
    ('Productos de Jardinería Decorativa', '<p>Productos de Jardinería Decorativa</p>', 'jardineria_decorativa.jpg'),
    ('Herramientas de Jardinería Profesionales', '<p>Herramientas de Jardinería Profesionales</p>', 'herramientas_jardineria.jpg'),
    ('Mobiliario de Exterior Moderno', '<p>Mobiliario de Exterior Moderno</p>', 'mobiliario_exterior.jpg'),
    ('Plantas Ornamentales de Interior', '<p>Plantas Ornamentales de Interior</p>', 'plantas_ornamentales.jpg'),
    ('Iluminación LED para Exteriores', '<p>Iluminación LED para Exteriores</p>', 'iluminacion_exterior.jpg');
   

INSERT INTO producto (nombre, gama_id, dimensiones, descripcion, cantidad_en_stock) VALUES
    ('Fuente de Agua de Piedra', 1, '60x80 cm', 'Fuente de agua decorativa con diseño de piedra natural', 50),
    ('Maceta de Cerámica Pintada a Mano', 1, '30x30 cm', 'Maceta de cerámica pintada a mano con diseño floral', 80),
    ('Estatuilla de Hada para Jardín', 1, '20x40 cm', 'Estatuilla de hada en resina para decorar jardines', 30),
    ('Cortasetos Profesional', 2, '60 cm de hoja', 'Cortasetos eléctrico profesional con cuchillas de acero', 20),
    ('Pala de Jardinería Robusta', 2, '30 cm de ancho', 'Pala de jardinería con mango ergonómico y hoja de acero', 40),
    ('Sofá de Ratán con Cojines', 3, '200x80x60 cm', 'Sofá de ratán para exteriores con cojines impermeables', 15),
    ('Mesa de Comedor de Acero y Vidrio', 3, '150x90x75 cm', 'Mesa de comedor para exteriores con estructura de acero y sobre de vidrio', 10),
    ('Sofá de Ratán con Cojines', 3, '200x80x60 cm', 'Sofá de ratán para exteriores con cojines impermeables', 15),
    ('Mesa de Comedor de Acero y Vidrio', 3, '150x90x75 cm', 'Mesa de comedor para exteriores con estructura de acero y sobre de vidrio', 10),
    ('Palma Areca', 4, 'Altura aproximada 150 cm', 'Planta de interior con hojas verdes y frondosas', 25),
    ('Orquídea Phalaenopsis', 4, 'Maceta de 12 cm', 'Orquídea con flores blancas y rosa pálido', 35),
    ('Foco de Suelo LED', 5, 'Diámetro 10 cm', 'Foco de suelo LED de bajo consumo para iluminación exterior', 50),
    ('Aplique de Pared LED Solar', 5, '15x10x5 cm', 'Aplique de pared LED con panel solar integrado', 40);

INSERT INTO precio (producto_id, precio_venta, proveedor_id, precio_proveedor) VALUES
    (1, 129.99, 1, 100.00),
    (2, 49.99, 2, 35.00),
    (3, 79.99, 3, 60.00),
    (4, 149.99, 4, 120.00),
    (5, 39.99, 5, 30.00),
    (6, 299.99, 6, 240.00),
    (7, 199.99, 1, 180.00),
    (8, 249.99, 2, 200.00),
    (9, 299.99, 3, 240.00),
    (10, 19.99, 4, 15.00),
    (11, 29.99, 5, 25.00),
    (12, 49.99, 6, 40.00),
    (13, 14.99, 1, 10.00);

INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, numero_linea) VALUES 
    (1, 1, 5, 1),
    (2, 1, 3, 2),
    (3, 2, 2, 1),
    (4, 3, 4, 1),
    (5, 4, 1, 1),
    (6, 4, 2, 2),
    (7, 5, 3, 1),
    (8, 5, 2, 2),
    (9, 6, 1, 1),
    (10, 7, 5, 1),
   	(11, 1, 5, 1),
    (12, 1, 3, 2),
    (13, 2, 2, 1),
    (14, 3, 4, 1),
    (15, 4, 1, 1),
    (16, 4, 2, 2),
    (17, 5, 3, 1),
    (18, 5, 2, 2),
    (19, 6, 1, 1),
    (20, 7, 5, 1),
   	(21, 4, 1, 1),
    (22, 4, 2, 2),
    (23, 5, 3, 1),
    (24, 5, 2, 2),
    (25, 6, 1, 1);

INSERT INTO telefono_cliente (cliente_id, tipo_id, numero) VALUES
    (1, 1, '621740260'),
    (1, 2, '874965241'),
    (2, 1, '639859640'),
    (3, 1, '502149865'),
    (4, 1, '857462010');
   	
   
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

SELECT 
	e.nombre AS nombre,
	e.apellido1 AS apellido1,
	e.apellido2 AS apellido2,
	e.email AS email
FROM
	empleado e
WHERE e.jefe_id = 7;

#4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
# empresa.

SELECT 
	p.puesto AS puesto,
	e.nombre AS nombre,
	e.apellido1 AS apellido1,
	e.apellido2 AS apellido2,
	e.email AS email
FROM 
	empleado e
INNER JOIN
	puesto p
ON
	p.id = e.puesto_id
WHERE 
	e.puesto_id = 1;

#5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
#   empleados que no sean representantes de ventas.

SELECT DISTINCT 
	e.nombre AS nombre,
	e.apellido1 AS apellido1,
	e.apellido2 AS apellido2,
	p.puesto AS puesto
FROM 
	empleado e
INNER JOIN
	puesto p
ON
	p.id = e.puesto_id
WHERE 
	e.puesto_id != 3;

#6 Devuelve un listado con el nombre de los todos los clientes españoles.

SELECT 
	c.nombre
FROM 
	cliente c
JOIN 
	direccion_cliente dc
ON
	c.id = dc.cliente_id
WHERE
	dc.pais_id = 1;

#7 Devuelve un listado con los distintos estados por los que puede pasar un
#  pedido.

SELECT * FROM estado_pedido ep;

#Devuelve un listado con el código de cliente de aquellos clientes que
# realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
#  aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:


# Utilizando la función YEAR de MySQL.

SELECT DISTINCT 
	c.id AS codigo
FROM 
	cliente c
JOIN
	pago p
ON
	c.id = p.cliente_id
WHERE YEAR(p.fecha_pago) = 2008;

# Utilizando la función DATE_FORMAT de MySQL.

SELECT DISTINCT 
	c.id AS codigo
FROM 
	cliente c
JOIN
	pago p
ON
	c.id = p.cliente_id
WHERE DATE_FORMAT(p.fecha_pago , "%Y") = '2008';

# Sin utilizar ninguna de las funciones anteriores.

SELECT DISTINCT 
	c.id AS codigo
FROM 
	cliente c
JOIN
	pago p
ON
	c.id = p.cliente_id
WHERE p.fecha_pago >= '2008-01-01' AND p.fecha_pago <= '2008-12-31';
	
#9. Devuelve un listado con el código de pedido, código de cliente, fecha
#    esperada y fecha de entrega de los pedidos que no han sido entregados a
#     tiempo.

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
	DATE(p.fecha_esperada) < DATE(p.fecha_entrega);

#10 Devuelve un listado con el código de pedido, código de cliente, fecha
#    esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
#     menos dos días antes de la fecha esperada.

# Utilizando la función ADDDATE de MySQL.


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

# Utilizando la función DATEDIFF de MySQL.

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
   
# ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
 
	
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

# 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
   
SELECT * FROM
	pedido p
WHERE
	p.estado_pedido_id = 6 AND YEAR(p.fecha_pedido) = '2009';

# 12. Devuelve un listado de todos los pedidos que han sido entregados en el
#  mes de enero de cualquier año.

SELECT * FROM
	pedido p 
WHERE
	p.estado_pedido_id = 5 AND MONTH(p.fecha_entrega) = '01';
	
# 13. Devuelve un listado con todos los pagos que se realizaron en el
#	año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

SELECT * FROM
	pago p
WHERE
	p.forma_pago_id = 4 AND YEAR(p.fecha_pago) = 2008
ORDER BY p.fecha_pago DESC;

# 14. Devuelve un listado con todas las formas de pago que aparecen en la
#  tabla pago. Tenga en cuenta que no deben aparecer formas de pago
#   repetidas.

SELECT DISTINCT 
	p.forma_pago_id AS ID,
	fp.forma AS FORMA
FROM
	pago p
JOIN
	forma_pago fp 
ON
	p.forma_pago_id = fp.id; 
	

#15. Devuelve un listado con todos los productos que pertenecen a la
#     gama Ornamentales y que tienen más de 100 unidades en stock. El listado
#      deberá estar ordenado por su precio de venta, mostrando en primer lugar
#       los de mayor precio.

SELECT * FROM
	producto p
WHERE
	p.gama_id = 1 AND p.cantidad_en_stock >= 100; 

# 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
#  cuyo representante de ventas tenga el código de empleado 11 o 30.

SELECT * FROM
    cliente c 
JOIN
    direccion_cliente dc
ON
    c.id = dc.cliente_id
WHERE
    dc.ciudad_id = 5
AND
    (c.empleado_id = 11 OR c.empleado_id = 30);


## Consultas multitabla (Composición interna)
   
# 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
#   representante de ventas.

   
SELECT 
	c.nombre AS "NOMBRE CLIENTE",	
	e.nombre AS "NOMBRE REP. VTAS"
FROM 
	cliente c
INNER JOIN
	empleado e
ON
	c.empleado_id = e.id;


#2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
#    nombre de sus representantes de ventas.

SELECT DISTINCT 
	p.id AS "COD PAGO",
	c.nombre AS "NOMBRE CLIENTE",	
	e.nombre AS "NOMBRE REP. VTAS"
FROM 
	cliente c
INNER JOIN
	empleado e ON
	c.empleado_id = e.id
INNER JOIN
	pago p ON
	c.id = p.cliente_id
ORDER BY p.id ASC; 
	
#3 Muestra el nombre de los clientes que no hayan realizado pagos junto con
#   el nombre de sus representantes de ventas.


SELECT DISTINCT 
	c.nombre AS "NOMBRE CLIENTE",	
	e.nombre AS "NOMBRE REP. VTAS"
FROM 
	cliente c
INNER JOIN
	empleado e ON c.empleado_id = e.id
LEFT JOIN
	pago p ON c.id = p.cliente_id
WHERE
	p.cliente_id IS NULL;

#4 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
#   representantes junto con la ciudad de la oficina a la que pertenece el
#    representante.

SELECT DISTINCT 
	c.nombre AS "NOMBRE CLIENTE",	
	e.nombre AS "NOMBRE REP. VTAS",
	c2.nombre AS "CIUDAD OFC. REP."
FROM 
	cliente c
INNER JOIN
	empleado e ON c.empleado_id = e.id
INNER JOIN
	oficina o ON e.oficina_id = o.id
INNER JOIN
	direccion_oficina do ON o.id = do.oficina_id
INNER JOIN
	ciudad c2 ON do.ciudad_id = c2.id;

#5 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
#   de sus representantes junto con la ciudad de la oficina a la que pertenece el
#    representante.

SELECT 
    c.nombre AS "NOMBRE CLIENTE", 
    e.nombre AS "NOMBRE REP. VTAS", 
    ci.nombre AS "CIUDAD OFC. REP."
FROM 
    cliente c
INNER JOIN 
    empleado e ON c.empleado_id = e.id
INNER JOIN 
    oficina o ON e.oficina_id = o.id
INNER JOIN 
    direccion_oficina do ON o.id = do.oficina_id
INNER JOIN 
    ciudad ci ON do.ciudad_id = ci.id
WHERE 
    c.id NOT IN (SELECT cliente_id FROM pago);