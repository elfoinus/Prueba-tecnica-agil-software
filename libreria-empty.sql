-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 04, 2021 at 02:55 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `IdCliente` int(11) NOT NULL,
  `Identificacion` varchar(20) NOT NULL,
  `Nombres` text NOT NULL,
  `Apellidos` text NOT NULL,
  `DireccionEnvio` text NOT NULL,
  `Celular` varchar(20) DEFAULT NULL,
  `Email` varchar(255) NOT NULL,
  `TelefonoFijo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `compra`
--

CREATE TABLE `compra` (
  `IdCompraLibro` int(11) NOT NULL,
  `IdLibro` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `Fecha` datetime NOT NULL,
  `Valor` double NOT NULL,
  `IdEmpleado` int(11) NOT NULL,
  `Comentario` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `editorial`
--

CREATE TABLE `editorial` (
  `IdEditorial` int(11) NOT NULL,
  `Nombre` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `empleado`
--

CREATE TABLE `empleado` (
  `IdEmpleado` int(11) NOT NULL,
  `Nombres` text NOT NULL,
  `Apellidos` text NOT NULL,
  `Direccion` text NOT NULL,
  `TelefonoFijo` varchar(20) NOT NULL,
  `Celular` varchar(20) NOT NULL,
  `Cargo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `libro`
--

CREATE TABLE `libro` (
  `IdLibro` int(11) NOT NULL,
  `Titulo` text NOT NULL,
  `IdEditorial` int(11) NOT NULL,
  `Fecha` year(4) DEFAULT NULL,
  `Costo` double NOT NULL,
  `PrecioSugerido` double DEFAULT NULL,
  `Autor` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`IdCliente`);

--
-- Indexes for table `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`IdCompraLibro`),
  ADD KEY `compra_cliente` (`idCliente`),
  ADD KEY `compra_empleado` (`IdEmpleado`),
  ADD KEY `Libro` (`IdLibro`);

--
-- Indexes for table `editorial`
--
ALTER TABLE `editorial`
  ADD PRIMARY KEY (`IdEditorial`);

--
-- Indexes for table `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`IdEmpleado`);

--
-- Indexes for table `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`IdLibro`),
  ADD KEY `libro_editorial` (`IdEditorial`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cliente`
--
ALTER TABLE `cliente`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `compra`
--
ALTER TABLE `compra`
  MODIFY `IdCompraLibro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `editorial`
--
ALTER TABLE `editorial`
  MODIFY `IdEditorial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `empleado`
--
ALTER TABLE `empleado`
  MODIFY `IdEmpleado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `libro`
--
ALTER TABLE `libro`
  MODIFY `IdLibro` int(11) NOT NULL AUTO_INCREMENT;

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
