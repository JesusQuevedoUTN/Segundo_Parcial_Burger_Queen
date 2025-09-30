-- DROP DATABASE IF EXISTS Burger_Queen;
-- CREATE DATABASE Burger_Queen CHARACTER SET utf8mb4;
USE Burger_Queen;

-- Tabla Cliente
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    telefono VARCHAR(15)
);

-- Tabla Local
CREATE TABLE Restaurante(
    id_local INT AUTO_INCREMENT PRIMARY KEY,
    ciudad VARCHAR(50) NOT NULL,
    pais VARCHAR(20) NOT NULL,
    region VARCHAR(30),
    codigo_postal VARCHAR(15) NOT NULL,
    telefono VARCHAR(20)
);

-- Tabla Empleado
CREATE TABLE Empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    codigo_local INT NOT NULL,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL, 
    puesto ENUM('Cajero', 'Gerente') NOT NULL,
    FOREIGN KEY (codigo_local) REFERENCES Restaurante(id_local)
);

-- Tabla Categoria_Producto
CREATE TABLE Categoria_Producto (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    descripcion TEXT,
    imagen VARCHAR(255)
);

-- Tabla Producto
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    precio_venta DECIMAL(15,2) NOT NULL,
    precio_compra DECIMAL(15,2) NOT NULL,
    id_categoria INT NOT NULL,
    cantidad_en_stock INT DEFAULT 0,
    FOREIGN KEY (id_categoria) REFERENCES Categoria_Producto(id_categoria)
);

-- Tabla Pedido
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    estado ENUM('Esperando', 'Listo', 'Entregado', 'Devuelto') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

-- Tabla Detalles_Pedido
CREATE TABLE Detalles_Pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Tabla Pago
CREATE TABLE Pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    forma_pago ENUM('Efectivo','Tarjeta','App') NOT NULL,
    monto_total DECIMAL(15,2) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

INSERT INTO Restaurante(id_local, ciudad, pais, region, codigo_postal, telefono)
VALUES (1, 'La Matanza', 'Argentina', 'Buenos Aires', '1758', '+54 911 111-111111');


-- Gerentes (Queen)
INSERT INTO Empleado (nombre, apellido, email, codigo_local, usuario, contrasena, puesto)
VALUES
('Freddie', 'Mercury', 'freddie@burgerqueen.com', 1, 'freddie', '1234', 'Gerente'),
('Brian', 'May', 'brian@burgerqueen.com', 1, 'brian', '1234', 'Gerente'),
('Roger', 'Taylor', 'roger@burgerqueen.com', 1, 'roger', '1234', 'Gerente'),
('John', 'Deacon', 'john@burgerqueen.com', 1, 'john', '1234', 'Gerente');

-- Cajeros (otras bandas/artistas)
INSERT INTO Empleado (nombre, apellido, email, codigo_local, usuario, contrasena, puesto)
VALUES
('Fernando', 'Cabrera', 'cabrera@burgerqueen.com', 1, 'cabrera', '1234', 'Cajero'), -- Cuarteto de Nos
('Sebastián', 'Teysera', 'sebastian@burgerqueen.com', 1, 'teysera', '1234', 'Cajero'), -- La Vela Puerca
('James', 'Hetfield', 'james@burgerqueen.com', 1, 'hetfield', '1234', 'Cajero'), -- Metallica
('Ozzy', 'Osbourne', 'ozzy@burgerqueen.com', 1, 'ozzy', '1234', 'Cajero'), -- Black Sabbath
('Justin', 'Bieber', 'justin@burgerqueen.com', 1, 'justin', '1234', 'Cajero'),
('Dan', 'Reynolds', 'dan@burgerqueen.com', 1, 'dan', '1234', 'Cajero'), -- Imagine Dragons
('Freddy', 'Curci', 'freddycurci@burgerqueen.com', 1, 'curci', '1234', 'Cajero'); -- Rata Blanca


INSERT INTO Cliente (nombre, apellido, email, telefono)
VALUES
('Homero', 'Simpson', 'homero@springfield.com', '111-111'),
('Marge', 'Simpson', 'marge@springfield.com', '111-112'),
('Bart', 'Simpson', 'bart@springfield.com', '111-113'),
('Lisa', 'Simpson', 'lisa@springfield.com', '111-114'),
('Bob', 'Esponja', 'bob@bikini.com', '222-111'),
('Patricio', 'Estrella', 'patricio@bikini.com', '222-112'),
('Shinji', 'Ikari', 'shinji@nerv.jp', '333-111'),
('Goku', 'Son', 'goku@dbz.com', '444-111'),
('Sailor', 'Moon', 'usagi@moon.jp', '555-111'),
('Finn', 'Mertens', 'finn@ooo.com', '666-111'),
('Jake', 'Perro', 'jake@ooo.com', '666-112');


INSERT INTO Categoria_Producto (nombre, descripcion, imagen)
VALUES
('Comida', 'Hamburguesas y comidas principales', 'comida.jpg'),
('Bebida', 'Gaseosas, agua, jugos', 'bebida.jpg'),
('Postre', 'Helados, tartas y dulces', 'postre.jpg'),
('Aderezo', 'Ketchup, mayonesa, mostaza', 'aderezo.jpg'),
('Combo', 'Combos especiales de Burger Queen', 'combo.jpg');

INSERT INTO Producto (nombre, descripcion, precio_venta, precio_compra, id_categoria, cantidad_en_stock)
VALUES
('Hamburguesa Clásica', 'Carne, lechuga, tomate y queso', 5.00, 2.50, 1, 100),
('Hamburguesa Doble', 'Dos carnes, cheddar, bacon', 7.50, 3.50, 1, 80),
('Papas Fritas', 'Porción mediana', 2.50, 1.00, 1, 150),
('Coca-Cola', 'Bebida 500ml', 2.00, 0.80, 2, 200),
('Sprite', 'Bebida 500ml', 2.00, 0.80, 2, 200),
('Helado de Vainilla', 'Copa de helado', 3.00, 1.20, 3, 70),
('Ketchup', 'Sobre de ketchup', 0.20, 0.05, 4, 500),
('Mayonesa', 'Sobre de mayonesa', 0.20, 0.05, 4, 500);


INSERT INTO Producto (nombre, descripcion, precio_venta, precio_compra, id_categoria, cantidad_en_stock)
VALUES
('Bohemian Rhapsody', 'Hamburguesa Doble + Papas + Coca-Cola', 11.00, 5.50, 5, 50),
('We Will Rock You', 'Hamburguesa Clásica + Papas + Sprite', 9.00, 4.50, 5, 60),
('Another One Bites The Dust', 'Hamburguesa Doble + Papas + Helado', 12.00, 6.00, 5, 40);


-- Pedido de Homero (compra en cantidad)
INSERT INTO Pedido (fecha_hora, id_cliente, id_empleado, estado)
VALUES (NOW(), 1, 5, 'Entregado'); -- Homero atendido por Justin Bieber (id_empleado=5)

-- Pedido de Shinji Ikari (solo una hamburguesa)
INSERT INTO Pedido (fecha_hora, id_cliente, id_empleado, estado)
VALUES (NOW(), 7, 6, 'Entregado'); -- Shinji atendido por Dan Reynolds (Imagine Dragons)

-- Pedido de Bob Esponja (combo especial)
INSERT INTO Pedido (fecha_hora, id_cliente, id_empleado, estado)
VALUES (NOW(), 5, 2, 'Entregado'); -- Bob Esponja atendido por Brian May


INSERT INTO Detalles_Pedido (id_pedido, id_producto, cantidad, precio_unitario)
VALUES
(1, 1, 5, 5.00),  -- 5 Hamburguesas Clásicas
(1, 3, 3, 2.50),  -- 3 Papas
(1, 4, 5, 2.00);  -- 5 Coca-Cola

INSERT INTO Detalles_Pedido (id_pedido, id_producto, cantidad, precio_unitario)
VALUES
(3, 9, 1, 11.00); -- Combo Bohemian Rhapsody

INSERT INTO Detalles_Pedido (id_pedido, id_producto, cantidad, precio_unitario)
VALUES
(2, 2, 1, 7.50);


INSERT INTO Pago (id_pedido, forma_pago, monto_total, fecha)
VALUES (3, 'App', 11.00, CURDATE());

INSERT INTO Pago (id_pedido, forma_pago, monto_total, fecha)
VALUES (2, 'Tarjeta', 7.50, CURDATE());

INSERT INTO Pago (id_pedido, forma_pago, monto_total, fecha)
VALUES (1, 'Efectivo', 44.50, CURDATE());