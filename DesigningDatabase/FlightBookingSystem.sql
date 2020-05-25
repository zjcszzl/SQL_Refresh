-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FlightBookingSystem
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FlightBookingSystem
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FlightBookingSystem` DEFAULT CHARACTER SET utf8 ;
USE `FlightBookingSystem` ;

-- -----------------------------------------------------
-- Table `FlightBookingSystem`.`Passenger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FlightBookingSystem`.`Passenger` (
  `passenger_id` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`passenger_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FlightBookingSystem`.`Airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FlightBookingSystem`.`Airline` (
  `airline_id` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`airline_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FlightBookingSystem`.`Airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FlightBookingSystem`.`Airport` (
  `airport_id` VARCHAR(45) NOT NULL,
  `IATACode` VARCHAR(10) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`airport_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FlightBookingSystem`.`Flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FlightBookingSystem`.`Flight` (
  `Number` VARCHAR(10) NOT NULL,
  `Departure` DATETIME NOT NULL,
  `Arrival` DATETIME NOT NULL,
  `Duration` INT NOT NULL,
  `Distance` INT NOT NULL,
  `airline_id` VARCHAR(45) NOT NULL,
  `departure_airport_id` VARCHAR(45) NOT NULL,
  `arrival_airport_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Number`),
  INDEX `fk_Flight_Airline1_idx` (`airline_id` ASC) VISIBLE,
  INDEX `fk_Flight_Airport1_idx` (`departure_airport_id` ASC) VISIBLE,
  INDEX `fk_Flight_Airport2_idx` (`arrival_airport_id` ASC) VISIBLE,
  CONSTRAINT `fk_Flight_Airline1`
    FOREIGN KEY (`airline_id`)
    REFERENCES `FlightBookingSystem`.`Airline` (`airline_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Airport1`
    FOREIGN KEY (`departure_airport_id`)
    REFERENCES `FlightBookingSystem`.`Airport` (`airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Airport2`
    FOREIGN KEY (`arrival_airport_id`)
    REFERENCES `FlightBookingSystem`.`Airport` (`airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FlightBookingSystem`.`FlightClass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FlightBookingSystem`.`FlightClass` (
  `class_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`class_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FlightBookingSystem`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FlightBookingSystem`.`Ticket` (
  `ticket_number` VARCHAR(45) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `confirmation_number` VARCHAR(45) NOT NULL,
  `flight_Number` VARCHAR(45) NOT NULL,
  `class_id` INT NOT NULL,
  `passenger_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ticket_number`),
  INDEX `fk_Ticket_Flight1_idx` (`flight_Number` ASC) VISIBLE,
  INDEX `fk_Ticket_FlightClass1_idx` (`class_id` ASC) VISIBLE,
  INDEX `fk_Ticket_Passenger1_idx` (`passenger_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ticket_Flight1`
    FOREIGN KEY (`flight_Number`)
    REFERENCES `FlightBookingSystem`.`Flight` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_FlightClass1`
    FOREIGN KEY (`class_id`)
    REFERENCES `FlightBookingSystem`.`FlightClass` (`class_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Passenger1`
    FOREIGN KEY (`passenger_id`)
    REFERENCES `FlightBookingSystem`.`Passenger` (`passenger_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
