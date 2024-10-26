CREATE DATABASE freddymotos;
USE freddymotos;

CREATE TABLE rol (
idrol int primary key auto_increment,
--
rol enum('usuario','administrador')
);

CREATE TABLE usuario (
idusuario int primary key auto_increment,
--
nombre varchar(250),
correo varchar(250) not null,
telefono int,
contrasena varchar(250) not null,
fecha_registro datetime default current_timestamp,
foto_perfil varchar(255),
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
estado boolean default true, -- 1 activo 0 inactivo
--
idrol int,
FOREIGN KEY (idrol) REFERENCES rol(idrol)
);

CREATE TABLE categoria (
idcategoria int primary key auto_increment,
--
nombre varchar(250),
descripcion text,
activo boolean default true
);

CREATE TABLE marca (
idmarca int primary key auto_increment,
--
nombre varchar(250),
descripcion text,
activo boolean default true
);

CREATE TABLE producto (
idproducto int primary key auto_increment,
--
nombre varchar(250),
precio decimal (10, 2),
descripcion text,
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
activo boolean default true, -- 1: el producto está publicado
--
idcategoria INT,
idmarca INT,
FOREIGN KEY (idcategoria) REFERENCES categoria(idcategoria),
FOREIGN KEY (idmarca) REFERENCES marca(idmarca)
);

CREATE TABLE inventario (
idinventario int primary key auto_increment,
--
fecha_entrada date,
motivo enum('venta', 'devolucion', 'nuevo', 'ajuste'),
tipo boolean, -- 0 entrada, 1 salida
cantidad_disponible int,
--
idproducto int,
FOREIGN KEY (idproducto) REFERENCES producto(idproducto)
);

CREATE TABLE pedido (
idpedido int primary key auto_increment,
--
fecha_pedido datetime default current_timestamp,
total decimal(10, 2),
estado varchar (255),
--
idusuario int,
FOREIGN KEY (idusuario) REFERENCES usuario(idusuario)
);

CREATE TABLE detallepedido (
iddetallepedido int primary key auto_increment,
--
descuento_porcentual decimal(5, 2) default 0,
descuento_fijo decimal(10, 2) default 0,
cantidad int, -- cantidad de productos en el pedido
precio_unitario decimal(10, 2), -- Precio del producto al momento de la compra
subtotal decimal(10,2),
--
idpedido int,
idproducto int,
idinventario int,
FOREIGN KEY (idpedido) REFERENCES pedido(idpedido),
FOREIGN KEY (idinventario) REFERENCES inventario(idinventario),
FOREIGN KEY (idproducto) REFERENCES producto(idproducto)
);

CREATE TABLE proveedor (
idproveedor int primary key auto_increment,
--
nombre_empresa varchar(100),
nombre_contacto varchar(100),
direccion varchar(150),
telefono varchar(15),
correo varchar(100),
sitio_web varchar(100)
);

CREATE TABLE zonaenvio (
idzonaenvio int primary key auto_increment,
--
provincia varchar(250),
ciudad varchar(250),
calle varchar(250)
);

CREATE TABLE metodopago (
idmetodopago int primary key auto_increment,
--
nombre enum('transferencia', 'tarjeta de credito', 'tarjeta de debito')
);

CREATE TABLE pago (
idpago int primary key auto_increment,
--
fecha_realizado datetime default current_timestamp,
estado_pago varchar(255),
--
idusuario int,
idpedido int,
idproveedor int,
idmetodopago int,
FOREIGN KEY (idmetodopago) REFERENCES metodopago(idmetodopago),
FOREIGN KEY (idproveedor) REFERENCES proveedor(idproveedor),
FOREIGN KEY (idpedido) REFERENCES pedido(idpedido),
FOREIGN KEY (idusuario) REFERENCES usuario(idusuario)
);

CREATE TABLE envio (
idenvio int primary key auto_increment,
--
fecha_envio date,
fecha_entrega_estimada date,
metodo_envio varchar(250),
costo_envio decimal(10, 2),
codigo_seguimiento varchar(250),
contacto_telefono varchar(100),
observaciones text,
direccion_entrega varchar(250),
estado_envio varchar(255),
--
idpedido int unique,
idzonaenvio int,
FOREIGN KEY (idpedido) REFERENCES pedido(idpedido),
FOREIGN KEY (idzonaenvio) REFERENCES zonaenvio(idzonaenvio)
);



