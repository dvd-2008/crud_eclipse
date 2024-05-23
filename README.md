Primero instalamos el TOMCAT 9.0 :

![image](https://github.com/dvd-2008/crud_eclipse/assets/128089437/7db5467e-1d6e-4e1f-9ae5-b7345a896824)

intgegramos la libreria para la coneccion :

![image](https://github.com/dvd-2008/crud_eclipse/assets/128089437/c5b1fb0c-a617-4347-8fa5-eac7a09b31d1)

clase CONEXION :

![image](https://github.com/dvd-2008/crud_eclipse/assets/128089437/d50109fe-1f09-45ae-99ca-1239e3648e92)

Use la clase servelet para los controladores :

![image](https://github.com/dvd-2008/crud_eclipse/assets/128089437/b6b42c90-df7a-463f-bda1-466408e654fd)

Por medio del metodo POST , creamos el login.jsp y el index.jsp :

![image](https://github.com/dvd-2008/crud_eclipse/assets/128089437/7949dd46-ff3b-4605-8038-6d328216ec2b)

mostramos corriendo el sistema : usuario : obrero password : obre 

![image](https://github.com/dvd-2008/crud_eclipse/assets/128089437/c5eb911f-f1cd-4ab3-a3fc-f95eaeae4508)

usamos la libreria sweet alert :

![image](https://github.com/dvd-2008/crud_eclipse/assets/128089437/78c2a831-c379-4d5c-8cbf-a845fb6d4293)

y nos muestra un CRUD  funcional :

![image](https://github.com/dvd-2008/crud_eclipse/assets/128089437/42860dd0-6ab0-4421-af23-062bac06b0fa)

acontinuacion el SCRIPT DE LA base de datos :





-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3315
-- Tiempo de generación: 23-05-2024 a las 02:48:48
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `banco_senati`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `n_cuenta` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `dni` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`n_cuenta`, `nombre`, `apellido`, `dni`) VALUES
(1001, 'daniel', 'calzada', '25805514'),
(1002, 'cecilia', 'arias', '09903285'),
(1003, 'JUAN', 'romero', '47411693'),
(1004, 'JUAN', 'maxi', '85214795'),
(1005, 'daniel', 'pinedo', '85214796'),
(1006, 'carlos', 'quesada', '14852369');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `depositos`
--

CREATE TABLE `depositos` (
  `cod_dep` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `monto` int(11) NOT NULL,
  `cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `depositos`
--

INSERT INTO `depositos` (`cod_dep`, `fecha`, `monto`, `cliente`) VALUES
(1, '2017-02-01', 1000, 1001),
(2, '2017-02-02', 500, 1001),
(3, '2017-02-01', 2500, 1002),
(4, '2017-02-02', 300, 1002),
(6, '2022-02-23', 3000, 1003),
(7, '2022-02-23', 1500, 1005);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago_servicios`
--

CREATE TABLE `pago_servicios` (
  `cod_pag` int(11) NOT NULL,
  `concepto` varchar(30) NOT NULL,
  `fecha` date NOT NULL,
  `monto` int(11) NOT NULL,
  `cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `pago_servicios`
--

INSERT INTO `pago_servicios` (`cod_pag`, `concepto`, `fecha`, `monto`, `cliente`) VALUES
(1, 'pago de telefono', '2017-02-20', 75, 1001),
(2, 'pago del agua', '2017-02-27', 95, 1002);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `retiros`
--

CREATE TABLE `retiros` (
  `cod_ret` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `monto` int(11) NOT NULL,
  `cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `retiros`
--

INSERT INTO `retiros` (`cod_ret`, `fecha`, `monto`, `cliente`) VALUES
(1, '2017-02-18', 100, 1001),
(2, '2017-02-25', 100, 1001),
(3, '2017-02-18', 500, 1002),
(4, '2017-02-25', 100, 1002),
(6, '2022-02-23', 100, 1003);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(40) NOT NULL,
  `password` varchar(5) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `password`) VALUES
(1, 'obrero', 'obre'),
(2, 'empleado', 'emple'),
(50, 'carlos', '8sa'),
(49, 'daniel', 'pepe');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`n_cuenta`);

--
-- Indices de la tabla `depositos`
--
ALTER TABLE `depositos`
  ADD PRIMARY KEY (`cod_dep`),
  ADD KEY `cliente` (`cliente`),
  ADD KEY `cliente_2` (`cliente`);

--
-- Indices de la tabla `pago_servicios`
--
ALTER TABLE `pago_servicios`
  ADD PRIMARY KEY (`cod_pag`),
  ADD KEY `cliente` (`cliente`);

--
-- Indices de la tabla `retiros`
--
ALTER TABLE `retiros`
  ADD PRIMARY KEY (`cod_ret`),
  ADD KEY `cliente` (`cliente`),
  ADD KEY `cliente_2` (`cliente`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `depositos`
--
ALTER TABLE `depositos`
  MODIFY `cod_dep` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `pago_servicios`
--
ALTER TABLE `pago_servicios`
  MODIFY `cod_pag` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `retiros`
--
ALTER TABLE `retiros`
  MODIFY `cod_ret` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `depositos`
--
ALTER TABLE `depositos`
  ADD CONSTRAINT `depositos_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`n_cuenta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pago_servicios`
--
ALTER TABLE `pago_servicios`
  ADD CONSTRAINT `pago_servicios_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`n_cuenta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `retiros`
--
ALTER TABLE `retiros`
  ADD CONSTRAINT `retiros_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`n_cuenta`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
