-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `library` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `library` ;

-- -----------------------------------------------------
-- Table `library`.`librarian`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`librarian` (
  `l-ID` DECIMAL(10,0) NOT NULL,
  `first-name` VARCHAR(10) NOT NULL,
  `last-name` VARCHAR(15) NULL DEFAULT NULL,
  `date-of-birth` DATE NULL DEFAULT NULL,
  `phone-number` VARCHAR(15) NULL DEFAULT NULL,
  `salary` DECIMAL(8,0) NULL DEFAULT NULL,
  PRIMARY KEY (`l-ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `library`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`area` (
  `name` VARCHAR(30) NOT NULL,
  `librarian` DECIMAL(10,0) NULL DEFAULT NULL,
  `start-shelf` DECIMAL(3,0) NULL DEFAULT NULL,
  `end-shelf` DECIMAL(3,0) NULL DEFAULT NULL,
  PRIMARY KEY (`name`),
  INDEX `ibid_idx` (`librarian` ASC) VISIBLE,
  CONSTRAINT `ibid`
    FOREIGN KEY (`librarian`)
    REFERENCES `library`.`librarian` (`l-ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `library`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`book` (
  `b-ID` VARCHAR(20) GENERATED ALWAYS AS (concat(left(`author`,5),_utf8mb4'-',left(`publication-year`,4),_utf8mb4'-',format(`shelf`,3))) STORED,
  `shelf` DECIMAL(3,0) NULL DEFAULT NULL,
  `title` VARCHAR(200) NOT NULL,
  `author` VARCHAR(100) NULL DEFAULT NULL,
  `publisher` VARCHAR(100) NULL DEFAULT NULL,
  `publication-year` VARCHAR(15) NULL DEFAULT NULL,
  `language` VARCHAR(20) NULL DEFAULT NULL,
  `ISBN` DECIMAL(13,0) NULL DEFAULT NULL,
  PRIMARY KEY (`b-ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `library`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`member` (
  `m-ID` DECIMAL(10,0) NOT NULL,
  `first-name` VARCHAR(10) NOT NULL,
  `last-name` VARCHAR(15) NOT NULL,
  `date-of-birth` DATE NULL DEFAULT NULL,
  `phone-number` VARCHAR(15) NULL DEFAULT NULL,
  `date-of-membership` DATE NULL DEFAULT NULL,
  `tot-fine` DECIMAL(5,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`m-ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `library`.`borrows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`borrows` (
  `m-ID` DECIMAL(10,0) NOT NULL,
  `b-ID` VARCHAR(20) NOT NULL,
  `borrow-date` DATE NOT NULL,
  `return-date` DATE NULL DEFAULT NULL,
  `status` VARCHAR(10) NULL DEFAULT NULL,
  `fine` DECIMAL(5,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`m-ID`, `b-ID`, `borrow-date`),
  INDEX `borrows_ibfk_2` (`b-ID` ASC) VISIBLE,
  CONSTRAINT `borrows_ibfk_1`
    FOREIGN KEY (`m-ID`)
    REFERENCES `library`.`member` (`m-ID`)
    ON DELETE RESTRICT,
  CONSTRAINT `borrows_ibfk_2`
    FOREIGN KEY (`b-ID`)
    REFERENCES `library`.`book` (`b-ID`)
    ON DELETE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
