-- MySQL Script generated by MySQL Workbench
-- 05/05/16 00:38:25
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Admin` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Admin` (
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Username`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Art Dealer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Art Dealer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Art Dealer` (
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Supervisor_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Username`),
  INDEX `Supervisor_Username_idx` (`Supervisor_Name` ASC),
  CONSTRAINT `Supervisor_Username`
    FOREIGN KEY (`Supervisor_Name`)
    REFERENCES `mydb`.`Admin` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `Employee_id` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Job Role` VARCHAR(45) NOT NULL,
  `Manger_username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Employee_id`),
  INDEX `Manger_username_idx` (`Manger_username` ASC),
  CONSTRAINT `Manger_username`
    FOREIGN KEY (`Manger_username`)
    REFERENCES `mydb`.`Art Dealer` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Age` VARCHAR(45) NOT NULL,
  `Sex` VARCHAR(45) NOT NULL,
  `Taste` VARCHAR(45) NULL DEFAULT 'Null',
  `ArtDealer_Username` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Username`),
  INDEX `ArtDealer_Username_idx` (`ArtDealer_Username` ASC),
  CONSTRAINT `ArtDealer_Username`
    FOREIGN KEY (`ArtDealer_Username`)
    REFERENCES `mydb`.`Art Dealer` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Events` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Events` (
  `Event_ID` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Location` VARCHAR(45) NOT NULL DEFAULT 'Art Gallery',
  `Theme` VARCHAR(45) NOT NULL,
  `Date` DATE NOT NULL,
  `Art_Dealer_Username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Event_ID`),
  INDEX `Art_Dealer_Username_idx` (`Art_Dealer_Username` ASC),
  CONSTRAINT `Art_Dealer_Username`
    FOREIGN KEY (`Art_Dealer_Username`)
    REFERENCES `mydb`.`Art Dealer` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Artist` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Artist` (
  `Username` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Sex` VARCHAR(45) NOT NULL,
  `Age` INT NOT NULL,
  `Style` VARCHAR(45) NOT NULL,
  `Nationality` VARCHAR(45) NOT NULL,
  `ArtDealer_Username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Username`),
  INDEX `ArtDealer_Username_idx` (`ArtDealer_Username` ASC),
  CONSTRAINT `ArtDealer_Username`
    FOREIGN KEY (`ArtDealer_Username`)
    REFERENCES `mydb`.`Art Dealer` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Paintings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Paintings` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Paintings` (
  `Painting_ID` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Painting_Type` VARCHAR(45) NOT NULL,
  `Base_Price` VARCHAR(45) NOT NULL DEFAULT 0,
  `Last_Sold_Price` VARCHAR(45) NULL,
  `Artist_Username` VARCHAR(45) NULL,
  `Customer_Username` VARCHAR(45) NULL,
  `Customer_Purchases_Username` VARCHAR(45) NULL,
  `Artist_Ask_Price` VARCHAR(45) NULL,
  `Artrist_Sold_Price` VARCHAR(45) NULL,
  `Artist_Date` VARCHAR(45) NULL,
  `Customer_Ask_Price` VARCHAR(45) NULL,
  `Customer_Sold_Price` VARCHAR(45) NULL,
  PRIMARY KEY (`Painting_ID`),
  INDEX `Artist_Username_idx` (`Artist_Username` ASC),
  INDEX `Customer_Username_idx` (`Customer_Username` ASC),
  INDEX `Customer_Purchases_Username_idx` (`Customer_Purchases_Username` ASC),
  CONSTRAINT `Artist_Username`
    FOREIGN KEY (`Artist_Username`)
    REFERENCES `mydb`.`Artist` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customer_Username`
    FOREIGN KEY (`Customer_Username`)
    REFERENCES `mydb`.`Customer` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customer_Purchases_Username`
    FOREIGN KEY (`Customer_Purchases_Username`)
    REFERENCES `mydb`.`Customer` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ticket` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Ticket` (
  `Ticket_ID` VARCHAR(45) NOT NULL,
  `Event_ID` VARCHAR(45) NOT NULL,
  `Customer_Username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Ticket_ID`),
  INDEX `Event_ID_idx` (`Event_ID` ASC),
  INDEX `Customer_Username_idx` (`Customer_Username` ASC),
  CONSTRAINT `Event_ID`
    FOREIGN KEY (`Event_ID`)
    REFERENCES `mydb`.`Events` (`Event_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customer_Username`
    FOREIGN KEY (`Customer_Username`)
    REFERENCES `mydb`.`Customer` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Artist_Registers_Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Artist_Registers_Event` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Artist_Registers_Event` (
  `Event_ID` VARCHAR(45) NOT NULL,
  `Artist_Username` VARCHAR(45) NOT NULL,
  INDEX `Event_ID_idx` (`Event_ID` ASC),
  INDEX `Artist_Username_idx` (`Artist_Username` ASC),
  CONSTRAINT `Event_ID`
    FOREIGN KEY (`Event_ID`)
    REFERENCES `mydb`.`Events` (`Event_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Artist_Username`
    FOREIGN KEY (`Artist_Username`)
    REFERENCES `mydb`.`Artist` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer_Registers_Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer_Registers_Event` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Customer_Registers_Event` (
  `Event_ID` VARCHAR(45) NOT NULL,
  `Customer_Username` VARCHAR(45) NOT NULL,
  INDEX `Event_ID_idx` (`Event_ID` ASC),
  INDEX `Customer_Username_idx` (`Customer_Username` ASC),
  CONSTRAINT `Event_ID`
    FOREIGN KEY (`Event_ID`)
    REFERENCES `mydb`.`Events` (`Event_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Customer_Username`
    FOREIGN KEY (`Customer_Username`)
    REFERENCES `mydb`.`Customer` (`Username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`Admin`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Admin` (`Username`, `Password`) VALUES ('mark11@gmail.com', 'mark@123');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Art Dealer`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Art Dealer` (`Username`, `Password`, `Supervisor_Name`) VALUES ('steve11@gmail.com', 'Steve@123', 'mark11@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Employee` (`Employee_id`, `Name`, `Job Role`, `Manger_username`) VALUES ('1', 'John ', 'Guard', 'steve11@gmail.com');
INSERT INTO `mydb`.`Employee` (`Employee_id`, `Name`, `Job Role`, `Manger_username`) VALUES ('2', 'Adam', 'Janitor', 'steve11@gmail.com');
INSERT INTO `mydb`.`Employee` (`Employee_id`, `Name`, `Job Role`, `Manger_username`) VALUES ('3', 'Andrew', 'Guard', 'steve11@gmail.com');
INSERT INTO `mydb`.`Employee` (`Employee_id`, `Name`, `Job Role`, `Manger_username`) VALUES ('4', 'Andy', 'Liftman', 'steve11@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Customer` (`Username`, `Password`, `Age`, `Sex`, `Taste`, `ArtDealer_Username`, `Name`) VALUES ('tim@gmail.com', 'tim@123', '42', 'Male', 'Abstract', 'steve11@gmail.com', 'Tim Cook');
INSERT INTO `mydb`.`Customer` (`Username`, `Password`, `Age`, `Sex`, `Taste`, `ArtDealer_Username`, `Name`) VALUES ('rose@gmail.com', 'rose@123', '37', 'Female', 'Conceptual', 'steve11@gmail.com', 'Rose Bentley');
INSERT INTO `mydb`.`Customer` (`Username`, `Password`, `Age`, `Sex`, `Taste`, `ArtDealer_Username`, `Name`) VALUES ('jack@gmail.com', 'jack@123', '28', 'Male', 'Impressionism', 'steve11@gmail.com', 'Jack Smith');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Events`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Events` (`Event_ID`, `Name`, `Location`, `Theme`, `Date`, `Art_Dealer_Username`) VALUES ('1', 'Art_Event_1', 'San Jose, California', 'Abstract', '05/15/2016', 'steve11@gmail.com');
INSERT INTO `mydb`.`Events` (`Event_ID`, `Name`, `Location`, `Theme`, `Date`, `Art_Dealer_Username`) VALUES ('2', 'Art_Event_2', 'Fremont, California', 'Conceptual', '05/20/2016', 'steve11@gmail.com');
INSERT INTO `mydb`.`Events` (`Event_ID`, `Name`, `Location`, `Theme`, `Date`, `Art_Dealer_Username`) VALUES ('3', 'Art_Event_3', 'San Francisco', 'Impressionism', '05/25/2016', 'steve11@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Artist`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Artist` (`Username`, `Password`, `Name`, `Sex`, `Age`, `Style`, `Nationality`, `ArtDealer_Username`) VALUES ('picasso11@gmail.com', 'Picasso@123', 'Pablo Picasso', 'Male', 73, 'Conceptual', 'Spain', 'steve11@gmail.com');
INSERT INTO `mydb`.`Artist` (`Username`, `Password`, `Name`, `Sex`, `Age`, `Style`, `Nationality`, `ArtDealer_Username`) VALUES ('vincent11@gmail.com', 'Vincent@123', 'Vincent van Gogh', 'Male', 67, 'Abstract', 'Netherlands', 'steve11@gmail.com');
INSERT INTO `mydb`.`Artist` (`Username`, `Password`, `Name`, `Sex`, `Age`, `Style`, `Nationality`, `ArtDealer_Username`) VALUES ('claude11@gmail.com', 'Claude@123', 'Claude Monet', 'Male', 62, 'Impressionism', 'France', 'steve11@gmail.com');
INSERT INTO `mydb`.`Artist` (`Username`, `Password`, `Name`, `Sex`, `Age`, `Style`, `Nationality`, `ArtDealer_Username`) VALUES (DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Ticket`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Ticket` (`Ticket_ID`, `Event_ID`, `Customer_Username`) VALUES ('1', '1', 'tim@gmail.com');
INSERT INTO `mydb`.`Ticket` (`Ticket_ID`, `Event_ID`, `Customer_Username`) VALUES ('2', '2', 'rose@gmail.com');
INSERT INTO `mydb`.`Ticket` (`Ticket_ID`, `Event_ID`, `Customer_Username`) VALUES ('3', '3', 'jack@gmail.com');
INSERT INTO `mydb`.`Ticket` (`Ticket_ID`, `Event_ID`, `Customer_Username`) VALUES ('4', '2', 'jack@gmail.com');
INSERT INTO `mydb`.`Ticket` (`Ticket_ID`, `Event_ID`, `Customer_Username`) VALUES ('5', '1', 'rose@gmail.com');
INSERT INTO `mydb`.`Ticket` (`Ticket_ID`, `Event_ID`, `Customer_Username`) VALUES ('6', '3', 'tim@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Artist_Registers_Event`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Artist_Registers_Event` (`Event_ID`, `Artist_Username`) VALUES ('1', 'picasso11@gmail.com');
INSERT INTO `mydb`.`Artist_Registers_Event` (`Event_ID`, `Artist_Username`) VALUES ('2', 'claude11@gmail.com');
INSERT INTO `mydb`.`Artist_Registers_Event` (`Event_ID`, `Artist_Username`) VALUES ('3', 'vincent11@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Customer_Registers_Event`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Customer_Registers_Event` (`Event_ID`, `Customer_Username`) VALUES ('1', 'tim@gmail.com');
INSERT INTO `mydb`.`Customer_Registers_Event` (`Event_ID`, `Customer_Username`) VALUES ('2', 'rose@gmail.com');
INSERT INTO `mydb`.`Customer_Registers_Event` (`Event_ID`, `Customer_Username`) VALUES ('1', 'rose@gmail.com');
INSERT INTO `mydb`.`Customer_Registers_Event` (`Event_ID`, `Customer_Username`) VALUES ('2', 'jack@gmail.com');
INSERT INTO `mydb`.`Customer_Registers_Event` (`Event_ID`, `Customer_Username`) VALUES ('3', 'jack@gmail.com');
INSERT INTO `mydb`.`Customer_Registers_Event` (`Event_ID`, `Customer_Username`) VALUES ('3', 'tim@gmail.com');

COMMIT;

USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`Art Dealer_AFTER_INSERT` $$
USE `mydb`$$
$$


DELIMITER ;
