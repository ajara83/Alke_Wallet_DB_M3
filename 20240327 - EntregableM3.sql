create database alkewallet_m3;

use alkewallet_m3;

-- Tabla de usuarios
create table usuario (
    user_id int auto_increment primary key,
    nombre varchar(255) not null,
    correo_electronico varchar(255) not null unique,
    contraseña varchar(255) not null,
    saldo float not null
);

-- Tabla de transacciones del sistema
create table transaccion (
    transaction_id int auto_increment primary key,
    sender_user_id int,
    receiver_user_id int,
    importe float not null,
    transaction_date datetime not null,
    foreign key (sender_user_id) references usuario(user_id),
    foreign key (receiver_user_id) references usuario(user_id)
);
-- Tabla de divisas disponibles para las transacciones
create table moneda (
    currency_id int auto_increment primary key,
    currency_name varchar(255) not null,
    currency_symbol varchar(10) not null
);

-- Actualizamos la tabla Transaccion para agregar una FK para la moneda
alter table transaccion
add column currency_id int,
add constraint fk_currency
foreign key (currency_id) references moneda(currency_id);

-- Poblamos los usuarios
insert into usuario (nombre, correo_electronico, contraseña, saldo) values
('Michael Burnham', 'burnham@gmail.com', 'password01', 3000.0),
('Saru', 'saru@gmail.com', 'password02', 2500.0),
('Paul Stamets', 'stamets@gmail.com', 'password03', 2200.0),
('Sylvia Tilly', 'tilly@gmail.com', 'password04', 2800.0),
('Christopher Pike', 'pike@gmail.com', 'password05', 2600.0);

-- Agregamos monedas
insert into moneda (currency_name, currency_symbol) values
('Peso Chileno', 'CLP'),
('Peso Argentino', 'ARS'),
('Dólar Estadounidense', 'USD');

-- Transacciones de prueba
insert into transaccion (sender_user_id, receiver_user_id, importe, transaction_date, currency_id) values
(1, 2, 500, '2024-03-25', 1), -- CLP
(2, 3, 300, '2024-03-26', 2), -- ARS
(3, 1, 100, '2024-03-27', 3); -- USD

insert into transaccion (sender_user_id, receiver_user_id, importe, transaction_date, currency_id) values
(1, 2, 500, now(), 1); -- CLP tomando la fecha y hora del momento del insert

-- Consulta para obtener el nombre de la moneda elegida por un usuario específico
select currency_name from moneda where currency_symbol='CLP';

-- Consulta para obtener todas las transacciones realizadas por un
-- usuario específico
select * from transaccion where sender_user_id=1 or receiver_user_id=1;

 -- Sentencia DML para modificar el campo correo electrónico de un
 -- usuario específico 
 update usuario set correo_electronico='pike@ussenterprice.un' where user_id=5;
 select * from usuario where user_id=5;

-- VALIDACION ESTRUCTURAL DE LA DDBB
delete from usuario where user_id=1;
-- El delete arroja error de constraint por las FK asignadas.

 -- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)
 delete from transaccion where transaction_id=4;
 select * from transaccion;








