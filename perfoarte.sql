CREATE DATABASE perfoarte
USE perfoarte

---------------------------------------------- SEDES

CREATE TABLE sedes(
idSede VARCHAR(50) PRIMARY KEY,
ubicacionSede VARCHAR(MAX),
telSede VARCHAR(30),
horarioSede VARCHAR(MAX))

CREATE PROCEDURE insertar_sede
@idSede VARCHAR(50),
@ubicacionSede VARCHAR(MAX),
@telSede VARCHAR(30),
@horarioSede VARCHAR(MAX)
AS
BEGIN
INSERT INTO sedes (idSede, ubicacionSede, telSede, horarioSede) VALUES(@idSede, @ubicacionSede, @telSede, @horarioSede)
END;

SELECT * FROM sedes

---------------------------------------------- USUARIOS

CREATE TABLE usuarios(
idUsuario VARCHAR(20) PRIMARY KEY,
nombreCompletoUs VARCHAR(MAX),
telUsuario VARCHAR(30),
correoUsuario VARCHAR(80) UNIQUE,
contraseñaUsuario VARCHAR(10),
fechaRegistroUs DATETIME)

CREATE PROCEDURE insertar_usuario
@idUsuario VARCHAR(20),
@nombreCompletoUs VARCHAR(MAX),
@telUsuario VARCHAR(30),
@correoUsuario VARCHAR(80),
@contraseñaUsuario VARCHAR(10),
@fechaRegistroUs DATETIME
AS
BEGIN
INSERT INTO usuarios (idUsuario, nombreCompletoUs, telUsuario, correoUsuario, contraseñaUsuario, fechaRegistroUs) VALUES (@idUsuario, @nombreCompletoUs, @telUsuario, @correoUsuario, @contraseñaUsuario, @fechaRegistroUs)
END;

SELECT * FROM usuarios 

---------------------------------------------- DESCUENTOS

CREATE TABLE descuentos(
idDescuento VARCHAR(80) PRIMARY KEY,
tituloDescuento VARCHAR(MAX),
periodoDescuento VARCHAR(MAX),
descripcionDescuento VARCHAR(MAX),
valorDescuento FLOAT)

CREATE PROCEDURE insertar_descuento
@idDescuento VARCHAR(80),
@tituloDescuento VARCHAR(MAX),
@periodoDescuento VARCHAR(MAX),
@descripcionDescuento VARCHAR(MAX),
@valorDescuento FLOAT
AS
BEGIN
INSERT INTO descuentos (idDescuento, tituloDescuento, periodoDescuento, descripcionDescuento, valorDescuento) VALUES(@idDescuento, @tituloDescuento, @periodoDescuento, @descripcionDescuento, @valorDescuento)
END;

SELECT * FROM descuentos 

---------------------------------------------- CLIENTES NO REGISTRADOS EN NUESTRA PÁGINA WEB

CREATE TABLE clientesNR(
idClienteNR VARCHAR(20) PRIMARY KEY,
nombreCompletoClienteNR VARCHAR(MAX),
telClienteNR VARCHAR(30),
correoClienteNR VARCHAR(MAX))

CREATE PROCEDURE insertar_clienteNR
@idClienteNR VARCHAR(20),
@nombreCompletoClienteNR VARCHAR(MAX),
@telClienteNR VARCHAR(30),
@correoClienteNR VARCHAR(MAX)
AS
BEGIN
INSERT INTO clientesNR (idClienteNR, nombreCompletoClienteNR, telClienteNR, correoClienteNR) VALUES(@idClienteNR, @nombreCompletoClienteNR, @telClienteNR, @correoClienteNR)
END;

SELECT * FROM clientesNR

---------------------------------------------- ARTISTAS

CREATE TABLE artistas(
idArtista VARCHAR(20) PRIMARY KEY,
nombreCompletoArtista VARCHAR(MAX),
biografiaArtista VARCHAR(MAX),
telArtista VARCHAR(30),
correoArtista VARCHAR(80) UNIQUE,
direccionArtista VARCHAR(MAX),
especialidadArtista VARCHAR(MAX),
idSede VARCHAR(50) 
CONSTRAINT fk_artistas FOREIGN KEY(idSede)
REFERENCES sedes(idSede))

CREATE PROCEDURE insertar_artista
@idArtista VARCHAR(20),
@nombreCompletoArtista VARCHAR(MAX),
@biografiaArtista VARCHAR(MAX),
@telArtista VARCHAR(30),
@correoArtista VARCHAR(80),
@direccionArtista VARCHAR(MAX),
@especialidadArtista VARCHAR(MAX),
@idSede VARCHAR(50) 
AS
BEGIN
INSERT INTO artistas(idArtista, nombreCompletoArtista, biografiaArtista, telArtista, correoArtista,direccionArtista, especialidadArtista, idSede) VALUES(@idArtista, @nombreCompletoArtista, @biografiaArtista, @telArtista, @correoArtista, @direccionArtista, @especialidadArtista, @idSede)
END;

SELECT * FROM artistas

---------------------------------------------- ADMINISTRADORES

CREATE TABLE administradores(
idAdministrador VARCHAR(20) PRIMARY KEY,
nombreCompletoAdmin VARCHAR(MAX),
telAdministrador VARCHAR(30),
correoAdministrador VARCHAR(80) UNIQUE,
contraseñaAdmin VARCHAR(10),
fechaRegistroAdmin DATETIME,
idSede VARCHAR(50) 
CONSTRAINT fk_administradores FOREIGN KEY(idSede)
REFERENCES sedes(idSede))

CREATE PROCEDURE insertar_administrador
@idAdministrador VARCHAR(20),
@nombreCompletoAdmin VARCHAR(MAX),
@telAdministrador VARCHAR(30),
@correoAdministrador VARCHAR(80),
@contraseñaAdmin VARCHAR(10),
@fechaRegistroAdmin DATETIME,
@idSede VARCHAR(50) 
AS
BEGIN
INSERT INTO administradores (idAdministrador, nombreCompletoAdmin, telAdministrador, correoAdministrador, contraseñaAdmin, fechaRegistroAdmin, idSede) VALUES(@idAdministrador, @nombreCompletoAdmin, @telAdministrador, @correoAdministrador, @contraseñaAdmin, @fechaRegistroAdmin, @idSede)
END;

SELECT * FROM administradores

---------------------------------------------- TRABAJOS

CREATE TABLE trabajos(
idTrabajo VARCHAR(70) PRIMARY KEY,
tipoTrabajo VARCHAR(50),
descripcionTrabajo VARCHAR(MAX),
idArtista VARCHAR(20)
CONSTRAINT fk_trabajos FOREIGN KEY(idArtista)
REFERENCES artistas(idArtista))

CREATE PROCEDURE insertar_trabajo
@idTrabajo VARCHAR(70),
@tipoTrabajo VARCHAR(50),
@descripcionTrabajo VARCHAR(MAX),
@idArtista VARCHAR(20)
AS
BEGIN
INSERT INTO trabajos (idTrabajo, tipoTrabajo, descripcionTrabajo, idArtista) VALUES(@idTrabajo, @tipoTrabajo, @descripcionTrabajo, @idArtista)
END;

SELECT * FROM trabajos

---------------------------------------------- RESERVAS

CREATE TABLE reservas(
idReserva VARCHAR(70) PRIMARY KEY,
fechaReserva DATETIME,
precioTotalReserva MONEY,
montoAbonoReserva MONEY,
montoRestanteReserva MONEY,
estadoReserva VARCHAR(MAX),
metodoReserva VARCHAR(80),
idSede VARCHAR(50),
idUsuario VARCHAR(20), 
idArtista VARCHAR(20),
idClienteNR VARCHAR(20),
idAdministrador VARCHAR(20),
idTrabajo VARCHAR(70)
CONSTRAINT fk_reservas1 FOREIGN KEY(idSede)
REFERENCES sedes(idSede),
CONSTRAINT fk_reservas2 FOREIGN KEY(idUsuario)
REFERENCES usuarios(idUsuario),
CONSTRAINT fk_reservas3 FOREIGN KEY(idArtista)
REFERENCES artistas(idArtista),
CONSTRAINT fk_reservas4 FOREIGN KEY(idClienteNR)
REFERENCES ClientesNR(idClienteNR),
CONSTRAINT fk_reservas5 FOREIGN KEY(idAdministrador)
REFERENCES administradores(idAdministrador),
CONSTRAINT fk_reservas6 FOREIGN KEY(idTrabajo)
REFERENCES trabajos(idTrabajo))

CREATE PROCEDURE insertar_reserva
@idReserva VARCHAR(70),
@fechaReserva DATETIME,
@precioTotalReserva MONEY,
@montoAbonoReserva MONEY,
@montoRestanteReserva MONEY,
@estadoReserva VARCHAR(MAX),
@metodoReserva VARCHAR(80),
@idSede VARCHAR(50),
@idUsuario VARCHAR(20),
@idArtista VARCHAR(20),
@idClienteNR VARCHAR(20),
@idAdministrador VARCHAR(20),
@idTrabajo VARCHAR(70)
AS
BEGIN
INSERT INTO reservas (idReserva, fechaReserva, precioTotalReserva, montoAbonoReserva, montoRestanteReserva, estadoReserva, metodoReserva, idSede, idUsuario, idArtista, idClienteNR, idAdministrador, idTrabajo) VALUES(@idReserva, @fechaReserva, @precioTotalReserva, @montoAbonoReserva, @montoRestanteReserva, @estadoReserva, @metodoReserva, @idSede, @idUsuario, @idArtista, @idClienteNR, @idAdministrador, @idTrabajo)
END;

SELECT * FROM reservas

---------------------------------------------- PAGOS

CREATE TABLE pagos(
idPago VARCHAR(70) PRIMARY KEY,
montoPago MONEY,
fechaPago DATETIME,
metodoPago VARCHAR(80),
idReserva VARCHAR(70),
idUsuario VARCHAR(20),
idClienteNR VARCHAR(20)
CONSTRAINT fk_p1 FOREIGN KEY(idReserva)
REFERENCES reservas(idReserva),
CONSTRAINT fk_p2 FOREIGN KEY(idUsuario)
REFERENCES usuarios(idUsuario),
CONSTRAINT fk_p3 FOREIGN KEY(idClienteNR)
REFERENCES clientesNR(idClienteNR))

CREATE PROCEDURE insertar_pago
@idPago VARCHAR(70),
@montoPago MONEY,
@fechaPago DATETIME,
@metodoPago VARCHAR(80),
@idReserva VARCHAR(70),
@idUsuario VARCHAR(20),
@idClienteNR VARCHAR(20)
AS
BEGIN
INSERT INTO pagos (idPago, montoPago, fechaPago, idReserva, idUsuario, idClienteNR) VALUES(@idPago, @montoPago, @fechaPago, @idReserva, @idUsuario, @idClienteNR)
END;

SELECT * FROM pagos

---------------------------------------------- NOTIFICACIONES

CREATE TABLE notificaciones(
idNotificacion VARCHAR(70) PRIMARY KEY,
mensajeNotificacion VARCHAR(MAX),
fechaNotificacion DATETIME,
estadoNotificacion VARCHAR(70),
idUsuario VARCHAR(20),
idClienteNR VARCHAR(20),
idArtista VARCHAR(20),
idAdministrador VARCHAR(20)
CONSTRAINT fk_n1 FOREIGN KEY(idUsuario)
REFERENCES usuarios(idUsuario),
CONSTRAINT fk_n2 FOREIGN KEY(idClienteNR)
REFERENCES clientesNR(idClienteNR),
CONSTRAINT fk_n3 FOREIGN KEY(idArtista)
REFERENCES artistas(idArtista),
CONSTRAINT fk_n4 FOREIGN KEY(idAdministrador)
REFERENCES administradores(idAdministrador))

CREATE PROCEDURE insertar_notificacion
@idNotificacion VARCHAR(70),
@mensajeNotificacion VARCHAR(MAX),
@fechaNotificacion DATETIME,
@estadoNotificacion VARCHAR(70),
@idUsuario VARCHAR(20),
@idClienteNR VARCHAR(20),
@idArtista  VARCHAR(20),
@idAdministrador VARCHAR(20)
AS
BEGIN
INSERT INTO notificaciones (idNotificacion, mensajeNotificacion, fechaNotificacion, estadoNotificacion, idUsuario, idClienteNR, idArtista, idAdministrador) VALUES (@idNotificacion, @mensajeNotificacion, @fechaNotificacion, @estadoNotificacion, @idUsuario, @idClienteNR, @idArtista, @idAdministrador)
END;

SELECT * FROM notificaciones

---------------------------------------------- RESERVAS_DESCUENTOS

CREATE TABLE reservas_descuentos(
idReserva VARCHAR(70),
idDescuento VARCHAR(80)
CONSTRAINT fk_rd1 FOREIGN KEY(idReserva)
REFERENCES reservas(idReserva),
CONSTRAINT fk_rd2 FOREIGN KEY(idDescuento)
REFERENCES descuentos(idDescuento))

CREATE PROCEDURE insertar_reservadescuento
@idReserva VARCHAR(70),
@idDescuento VARCHAR(80)
AS
BEGIN
INSERT INTO reservas_descuentos (idReserva, idDescuento) VALUES (@idReserva, @idDescuento)
END;

SELECT * FROM reservas_descuentos

--------------------------------------------------------------

-- Informe para conocer qué artistas trabajan en qué sede, según el ID de la misma:

CREATE PROCEDURE trabajadores_sedes
@idSede VARCHAR(50)
AS
BEGIN
SELECT ubicacionSede, idArtista, nombreCompletoArtista FROM artistas
INNER JOIN sedes ON artistas.idSede = sedes.idSede
WHERE sedes.idSede = @idSede
END;

SELECT * FROM sedes

-- Informe para conocer según el ID del cliente NO REGISTRADO, la sede y el artista con quien tiene una reserva:

CREATE PROCEDURE reservas_ClientesNR
@idClienteNR VARCHAR(20)
AS
BEGIN
SELECT nombreCompletoClienteNR, ubicacionSede, nombreCompletoArtista FROM artistas
INNER JOIN sedes ON artistas.idSede = sedes.idSede
INNER JOIN reservas ON reservas.idSede = sedes.idSede
INNER JOIN clientesNR ON reservas.idClienteNR = clientesNR.idClienteNR
WHERE clientesNR.idClienteNR = @idClienteNR
END; 

SELECT * FROM clientesNR

-- Informe para conocer según el ID de un usuario, su correo, su nombre, la descripción del trabajo que se realiza, su valor total y el artista con quién se llevó a cabo el mismo:

CREATE PROCEDURE procedimiento_usuario
@idUsuario VARCHAR(20)
AS
BEGIN 
SELECT nombreCompletoUs, correoUsuario, descripcionTrabajo, precioTotalReserva, nombreCompletoArtista FROM usuarios
INNER JOIN reservas ON reservas.idUsuario = usuarios.idUsuario
INNER JOIN trabajos ON reservas.idTrabajo = trabajos.idTrabajo
INNER JOIN artistas ON trabajos.idArtista = artistas.idArtista
WHERE usuarios.idUsuario = @idUsuario
END;

SELECT * FROM usuarios

-- Informe para conocer la biografía y la especialidad de un artista según la letra inicial de su nombre:

CREATE PROCEDURE especialidad_artista
AS
BEGIN
SELECT nombreCompletoArtista, biografiaArtista, especialidadArtista FROM artistas WHERE nombreCompletoArtista LIKE 'D%'
END;

-- Informe para conocer el precio de las reservas, su estado y metodo de reserva, la sede y el artista con quien se realizó o realizará la misma, según el id del artista:

CREATE PROCEDURE informacion_reservas
@idArtista VARCHAR(20)
AS
BEGIN
SELECT precioTotalReserva, estadoReserva, metodoReserva, ubicacionSede, nombreCompletoArtista FROM pagos
INNER JOIN reservas ON pagos.idReserva = reservas.idReserva
INNER JOIN artistas ON reservas.idArtista = artistas.idArtista
INNER JOIN sedes ON artistas.idSede = sedes.idSede
WHERE artistas.idArtista = @idArtista
END;

SELECT * FROM artistas

-- Informe para conseguir los valores mínimos y máximos de las reservas:

SELECT MIN(montoPago) AS PrecioMinimo FROM pagos
SELECT MAX(montoPago) AS PrecioMaximo FROM pagos

SELECT * FROM pagos

-- Informe para consultar el % de las ganancias adquiridas de las reservas, según el id sede:

CREATE PROCEDURE ganancias_Sedes
@idSede VARCHAR(50)
AS
BEGIN
SELECT ubicacionSede, AVG(montoPago) AS PorcentajeGanancias FROM pagos
INNER JOIN reservas ON pagos.idReserva = reservas.idReserva
INNER JOIN sedes ON reservas.idSede = sedes.idSede
WHERE sedes.idSede = @idSede
GROUP BY ubicacionSede
END;

SELECT * FROM sedes
SELECT * FROM pagos

-- Informe para consultar el valor total de las ventas que se han realizado a través de las reservas:

CREATE PROCEDURE info_totalVentas
AS
BEGIN
SELECT SUM(montoPago) AS TotalVentas FROM pagos
END;

SELECT * FROM pagos

-- Informe para consultar datos sobre un trabajo en específico según su id o tipo de trabajo:

SELECT idTrabajo, nombreCompletoArtista, descripcionTrabajo, tipoTrabajo FROM trabajos 
INNER JOIN artistas ON trabajos.idArtista = artistas.idArtista
WHERE idTrabajo = 'N67AC90' AND tipoTrabajo = 'Tattoo'

SELECT * FROM trabajos

