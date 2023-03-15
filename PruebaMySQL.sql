#-------------CREAR ESQUEMA-------------
CREATE SCHEMA MinimarketJose;
USE MinimarketJose;

#-------------CREAR TABLAS-------------

CREATE TABLE categoria (
categoria_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR (30)
);

CREATE TABLE producto (
producto_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR (30),
categoria_id INTEGER NOT NULL,
FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);

CREATE TABLE proveedor (
proveedor_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR (30)
);

CREATE TABLE venta (
venta_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
monto DOUBLE,
fecha DATE
);

#-------------CREAR TABLAS RELACIONALES-------------

CREATE TABLE productoProveedor (
productoProveedor_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
producto_id INTEGER NOT NULL,
proveedor_id INTEGER NOT NULL
);

CREATE TABLE productoVenta (
productoVenta_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
producto_id INTEGER NOT NULL,
venta_id INTEGER NOT NULL
);

#-------------INGRESAR DATOS A LAS TABLAS-------------

INSERT INTO categoria (nombre)
VALUES ("Frutas y Verduras"),("No Perecibles"),("Congelados"),("Bebestibles");

INSERT INTO producto (nombre, categoria_id)
VALUES ("Zanahoria",1), ("Frutilla",1),("Manzana",1),
("Arroz",2),("Fideos",2),("Porotos",2),
("Helado",3),("Hielo",3),("Verdura Congelada",3),
("Bebida",4),("Agua",4),("Energética",4);

INSERT INTO proveedor (nombre)
VALUES ("Frutas Don Ramón"),("Verduras Luisa"),("Carozzi"),("Tucapel"),
("Mayorista 10"),("CocaCola"),("Vital"),("Monster");

INSERT INTO venta (monto,fecha)
VALUES (9500,"2022-05-03"),(14700,"2022-07-15"),
(11500,"2022-09-01"),(12800,"2022-12-12"),(8900,"2023-02-28");

INSERT INTO productoProveedor(producto_id, proveedor_id)
VALUES (1,2),(2,1),(3,1),(4,4),(4,5),(5,3),(5,5),
(6,5),(7,5),(8,6),(9,5),(10,6),(11,6),(11,7),(12,8);

INSERT INTO productoVenta (producto_id,venta_id)
VALUES (1,1),(2,1),(3,1),(4,2),(5,2),(6,2),(7,3),(9,3),
(6,4),(11,4),(12,4),(3,5),(8,5),(10,5);

#-------------CONSULTAR DATOS-------------

#CONSULTAS GENERALES
SELECT * FROM categoria;
SELECT * FROM producto;
SELECT * FROM proveedor;
SELECT * FROM venta;
SELECT * FROM productoProveedor;
SELECT * FROM productoVenta;

#CONSULTAS JOIN

#Nombre del producto y su categoria.
SELECT producto.nombre, categoria.nombre
FROM producto JOIN categoria ON producto.categoria_id = categoria.categoria_id;


#Productos según categoría
SELECT categoria.nombre, producto.nombre
FROM producto JOIN categoria ON producto.categoria_id = categoria.categoria_id
WHERE categoria.nombre LIKE "frutas y verduras";

SELECT categoria.nombre, producto.nombre
FROM producto JOIN categoria ON producto.categoria_id = categoria.categoria_id
WHERE categoria.nombre LIKE "no perecibles";

SELECT categoria.nombre, producto.nombre
FROM producto JOIN categoria ON producto.categoria_id = categoria.categoria_id
WHERE categoria.nombre LIKE "congelados";

SELECT categoria.nombre, producto.nombre
FROM producto JOIN categoria ON producto.categoria_id = categoria.categoria_id
WHERE categoria.nombre LIKE "bebestibles";


#Producto según Proveedor
SELECT producto.nombre, proveedor.nombre
FROM productoProveedor 
JOIN producto ON productoProveedor.producto_id = producto.producto_id
JOIN proveedor ON productoProveedor.proveedor_id = proveedor.proveedor_id;

#¿Qué producto(s) trae x proveedor?
SELECT producto.nombre, proveedor.nombre
FROM productoProveedor 
JOIN producto ON productoProveedor.producto_id = producto.producto_id
JOIN proveedor ON productoProveedor.proveedor_id = proveedor.proveedor_id
WHERE proveedor.nombre LIKE "Mayorista 10";#se puede cambiar por el que se desee consultar.


#Productos según Venta
SELECT producto.nombre, venta.venta_id
FROM productoVenta
JOIN producto ON productoVenta.producto_id = producto.producto_id
JOIN venta ON productoVenta.venta_id = venta.venta_id;

#Montos según año venta. CON ESTE DATO SE PUEDEN SUMAR LOS MONTOS DEL AÑO.
SELECT monto, fecha
FROM venta
WHERE YEAR(fecha) = 2022;

#Producto por año. CON ESTE DATO SE PUEDE SABER EL PRODUCTO MÁS VENDIDO EN EL AÑO
SELECT producto.nombre, COUNT(producto.nombre) AS cantProducto
FROM productoVenta
JOIN venta ON productoVenta.venta_id = venta.venta_id
JOIN producto ON productoVenta.producto_id = producto.producto_id
WHERE YEAR(venta.fecha) = 2022 #se puede cambiar por el que se desee consultar. 
GROUP BY producto.nombre
ORDER BY cantProducto DESC;

#Categoría por año. CON ESTE DATO SE PUEDE SABER LA CATEGORIA MÁS VENDIDA EN EL AÑO
SELECT categoria.nombre, COUNT(categoria.nombre) AS cantCategoria
FROM productoVenta
JOIN venta ON productoVenta.venta_id = venta.venta_id
JOIN producto ON productoVenta.producto_id = producto.producto_id
JOIN categoria ON producto.categoria_id = categoria.categoria_id
WHERE YEAR(venta.fecha) = 2022 #se puede cambiar por el que se desee consultar.
GROUP BY categoria.nombre
ORDER BY cantCategoria DESC;

 