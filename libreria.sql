-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 04, 2021 at 06:42 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `libreria`
--
CREATE DATABASE IF NOT EXISTS `libreria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `libreria`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `compra_x_año`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `compra_x_año` (IN `ano` YEAR)  BEGIN SELECT * FROM compra WHERE YEAR(fecha) = ano; END$$

DROP PROCEDURE IF EXISTS `proc_sacar_clientes_tipo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_sacar_clientes_tipo` (IN `tipoCliente` INT)  BEGIN
 SELECT * FROM cliente WHERE IdCliente = tipoCliente;
 END$$

DROP PROCEDURE IF EXISTS `ventas_por_empleado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ventas_por_empleado` (IN `ano` YEAR)  BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `IdCliente` int(11) NOT NULL AUTO_INCREMENT,
  `Identificacion` varchar(20) NOT NULL,
  `Nombres` text NOT NULL,
  `Apellidos` text NOT NULL,
  `DireccionEnvio` text NOT NULL,
  `Celular` varchar(20) DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `TelefonoFijo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`IdCliente`),
  UNIQUE KEY `IdCliente` (`IdCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `cliente`
--

TRUNCATE TABLE `cliente`;
--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`IdCliente`, `Identificacion`, `Nombres`, `Apellidos`, `DireccionEnvio`, `Celular`, `Email`, `TelefonoFijo`) VALUES
(1, '1122334455', 'La casa del libro', '', 'carrera 15 # 32 - 65 - centro', '34596969', 'lacasadellibro@gmail.com', NULL),
(2, '1234567899', 'Daniela', 'Rubio', 'carrera 38 # 65-63', '3112564488', 'daniela.rubio@hotmail.com', '3279865'),
(3, '3996587265', 'Valentina', 'Abello', 'calle 12 # 95-55', '322659658', 'valentina.abello@outlook.es', '3879565'),
(4, '4512369878', 'Libreria municipal Dagua', '', 'calle 7 # 56-69 caseta municipal', '3006565', 'libreria.dagua@dagua-valle.gov.co', '3986565'),
(5, '6598321478', 'Jhon', 'Carabali', 'carrera 88 # 77-77', '3046056739', 'jhonhenr0710@gmail.com', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
CREATE TABLE IF NOT EXISTS `compra` (
  `IdCompraLibro` int(11) NOT NULL AUTO_INCREMENT,
  `IdLibro` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `Fecha` datetime NOT NULL,
  `Valor` double NOT NULL,
  `IdEmpleado` int(11) NOT NULL,
  `Comentario` text NOT NULL,
  PRIMARY KEY (`IdCompraLibro`),
  UNIQUE KEY `IdCompraLibro` (`IdCompraLibro`),
  KEY `compra_cliente` (`idCliente`),
  KEY `compra_empleado` (`IdEmpleado`),
  KEY `Libro` (`IdLibro`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `compra`
--

TRUNCATE TABLE `compra`;
--
-- Dumping data for table `compra`
--

INSERT INTO `compra` (`IdCompraLibro`, `IdLibro`, `idCliente`, `Fecha`, `Valor`, `IdEmpleado`, `Comentario`) VALUES
(1, 1, 1, '2020-12-04 03:38:53', 55000, 1, ''),
(2, 2, 2, '2018-12-04 03:38:53', 120000, 4, ''),
(3, 5, 1, '2019-12-04 03:52:20', 79000, 3, ''),
(4, 1, 1, '2020-12-04 03:52:20', 60000, 4, ''),
(5, 1, 1, '2020-12-04 03:38:53', 55000, 1, ''),
(6, 1, 3, '2021-12-04 06:16:54', 60000, 2, ''),
(7, 2, 3, '2019-12-04 06:16:54', 120000, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `editorial`
--

DROP TABLE IF EXISTS `editorial`;
CREATE TABLE IF NOT EXISTS `editorial` (
  `IdEditorial` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` text NOT NULL,
  PRIMARY KEY (`IdEditorial`),
  UNIQUE KEY `IdEditorial` (`IdEditorial`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `editorial`
--

TRUNCATE TABLE `editorial`;
--
-- Dumping data for table `editorial`
--

INSERT INTO `editorial` (`IdEditorial`, `Nombre`) VALUES
(1, 'Desconocida'),
(2, 'Sudamericana de Buenos Aires'),
(3, 'Alfaguara');

-- --------------------------------------------------------

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
CREATE TABLE IF NOT EXISTS `empleado` (
  `IdEmpleado` int(11) NOT NULL AUTO_INCREMENT,
  `Nombres` text NOT NULL,
  `Apellidos` text NOT NULL,
  `Direccion` text NOT NULL,
  `TelefonoFijo` varchar(20) NOT NULL,
  `Celular` varchar(20) NOT NULL,
  `Cargo` text NOT NULL,
  PRIMARY KEY (`IdEmpleado`),
  UNIQUE KEY `IdEmpleado` (`IdEmpleado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `empleado`
--

TRUNCATE TABLE `empleado`;
--
-- Dumping data for table `empleado`
--

INSERT INTO `empleado` (`IdEmpleado`, `Nombres`, `Apellidos`, `Direccion`, `TelefonoFijo`, `Celular`, `Cargo`) VALUES
(1, 'Anna', 'Ramirez', 'carrera 56 # 35 - 66', '3216598', '3056259876', 'Ventas'),
(2, 'Jhoanna', 'Galvez', 'calle 50 # 99 - 45', '', '', 'Ventas'),
(3, 'Juan', 'Ramirez', 'Carrera 30 # 35-11', '3266596', '', 'Ventas'),
(4, 'Beatriz', 'Florian', 'Calle 5 # 12-6', '', '3006593232', 'Gerente de ventas');

-- --------------------------------------------------------

--
-- Table structure for table `libro`
--

DROP TABLE IF EXISTS `libro`;
CREATE TABLE IF NOT EXISTS `libro` (
  `IdLibro` int(11) NOT NULL AUTO_INCREMENT,
  `Titulo` text NOT NULL,
  `IdEditorial` int(11) NOT NULL,
  `Fecha` year(4) DEFAULT NULL,
  `Costo` double NOT NULL,
  `PrecioSugerido` double DEFAULT NULL,
  `Autor` text DEFAULT NULL,
  PRIMARY KEY (`IdLibro`),
  UNIQUE KEY `IdLibro` (`IdLibro`),
  KEY `libro_editorial` (`IdEditorial`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `libro`
--

TRUNCATE TABLE `libro`;
--
-- Dumping data for table `libro`
--

INSERT INTO `libro` (`IdLibro`, `Titulo`, `IdEditorial`, `Fecha`, `Costo`, `PrecioSugerido`, `Autor`) VALUES
(1, 'Cien años de soledad', 2, 1967, 50000, 60000, 'Gabriel García Márquez'),
(2, 'El arte de la guerra', 1, 0000, 100000, 120000, 'Desconocido'),
(5, 'Historia del Rey Transparente', 3, 2005, 75000, 85000, 'Rosa Montero');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `Libro` FOREIGN KEY (`IdLibro`) REFERENCES `libro` (`IdLibro`),
  ADD CONSTRAINT `compra_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`IdCliente`),
  ADD CONSTRAINT `compra_empleado` FOREIGN KEY (`IdEmpleado`) REFERENCES `empleado` (`IdEmpleado`);

--
-- Constraints for table `libro`
--
ALTER TABLE `libro`
  ADD CONSTRAINT `libro_editorial` FOREIGN KEY (`IdEditorial`) REFERENCES `editorial` (`IdEditorial`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
