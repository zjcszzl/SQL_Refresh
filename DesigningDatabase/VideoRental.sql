-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema VideoRental
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema VideoRental
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `VideoRental` DEFAULT CHARACTER SET utf8 ;
USE `VideoRental` ;

-- -----------------------------------------------------
-- Table `VideoRental`.`Role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VideoRental`.`Role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VideoRental`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VideoRental`.`User` (
  `user_id` INT NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_User_Role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_Role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `VideoRental`.`Role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VideoRental`.`Permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VideoRental`.`Permission` (
  `permission_id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`permission_id`),
  INDEX `fk_Permission_Role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_Permission_Role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `VideoRental`.`Role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VideoRental`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VideoRental`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VideoRental`.`Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VideoRental`.`Movie` (
  `barcode` VARCHAR(45) NOT NULL,
  `daily_rental_rate` DECIMAL(5,2) NOT NULL,
  `number_in_stock` INT NOT NULL,
  `Moviecol` VARCHAR(45) NULL,
  PRIMARY KEY (`barcode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VideoRental`.`Coupon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VideoRental`.`Coupon` (
  `coupon_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `discount` INT NOT NULL,
  PRIMARY KEY (`coupon_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VideoRental`.`Rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VideoRental`.`Rental` (
  `idRental` INT NOT NULL,
  `number_of_days` INT NOT NULL,
  `coupon_id` INT NOT NULL,
  `rentDate` DATETIME NOT NULL,
  `returnDate` DATETIME NOT NULL,
  `barcode` VARCHAR(45) NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`idRental`),
  INDEX `fk_Rental_Coupon_idx` (`coupon_id` ASC) VISIBLE,
  INDEX `fk_Rental_Movie1_idx` (`barcode` ASC) VISIBLE,
  INDEX `fk_Rental_Customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Rental_Coupon`
    FOREIGN KEY (`coupon_id`)
    REFERENCES `VideoRental`.`Coupon` (`coupon_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rental_Movie1`
    FOREIGN KEY (`barcode`)
    REFERENCES `VideoRental`.`Movie` (`barcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rental_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `VideoRental`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
