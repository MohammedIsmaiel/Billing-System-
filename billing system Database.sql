-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema billing system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema billing system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `billing system` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `billing system` ;

-- -----------------------------------------------------
-- Table `billing system`.`hospital`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`hospital` ;

CREATE TABLE IF NOT EXISTS `billing system`.`hospital` (
  `hospital_id` INT NOT NULL AUTO_INCREMENT,
  `hospital_name` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`hospital_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`analysis_center`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`analysis_center` ;

CREATE TABLE IF NOT EXISTS `billing system`.`analysis_center` (
  `analysis_id` INT NOT NULL AUTO_INCREMENT,
  `hospital_id` INT NOT NULL,
  `analysis_price` DECIMAL(6,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`analysis_id`),
  INDEX `hospital_id` (`hospital_id` ASC) VISIBLE,
  CONSTRAINT `analysis_center_ibfk_1`
    FOREIGN KEY (`hospital_id`)
    REFERENCES `billing system`.`hospital` (`hospital_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`doctor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`doctor` ;

CREATE TABLE IF NOT EXISTS `billing system`.`doctor` (
  `doctor_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NULL DEFAULT NULL,
  `specialization` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`doctor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`employee` ;

CREATE TABLE IF NOT EXISTS `billing system`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `e-mail` VARCHAR(40) NULL DEFAULT NULL,
  `password` VARCHAR(40) NULL DEFAULT NULL,
  `gender` VARCHAR(1) NULL DEFAULT NULL,
  `username` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`patient` ;

CREATE TABLE IF NOT EXISTS `billing system`.`patient` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NULL DEFAULT NULL,
  `gender` VARCHAR(1) NULL DEFAULT NULL,
  `city` VARCHAR(20) NULL DEFAULT NULL,
  `address` VARCHAR(40) NULL DEFAULT NULL,
  `country` VARCHAR(20) NULL DEFAULT NULL,
  `nationality` VARCHAR(20) NULL DEFAULT NULL,
  `age` INT NULL DEFAULT NULL,
  PRIMARY KEY (`patient_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`examination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`examination` ;

CREATE TABLE IF NOT EXISTS `billing system`.`examination` (
  `patient_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  `examination_price` DECIMAL(6,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`patient_id`, `doctor_id`),
  INDEX `doctor_id` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `examination_ibfk_1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `billing system`.`patient` (`patient_id`)
    ON DELETE CASCADE,
  CONSTRAINT `examination_ibfk_2`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `billing system`.`doctor` (`doctor_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`insurance_system`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`insurance_system` ;

CREATE TABLE IF NOT EXISTS `billing system`.`insurance_system` (
  `num_insur_sys` INT NOT NULL AUTO_INCREMENT,
  `patient_id` INT NOT NULL,
  `name` VARCHAR(40) NULL DEFAULT NULL,
  `medicine_discount` INT NULL DEFAULT '0',
  `surgery_discount` INT NULL DEFAULT '0',
  `analysis_discount` INT NULL DEFAULT '0',
  `Intensive_cares_discount` INT NULL DEFAULT '0',
  `examination_discount` INT NULL DEFAULT '0',
  `normal_room_discount` INT NULL DEFAULT '0',
  `max_discount` DECIMAL(9,2) NULL DEFAULT '0.00',
  `patient_consumption` DECIMAL(9,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`num_insur_sys`, `patient_id`),
  INDEX `patient_id` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `insurance_system_ibfk_1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `billing system`.`patient` (`patient_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`intensive_cares`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`intensive_cares` ;

CREATE TABLE IF NOT EXISTS `billing system`.`intensive_cares` (
  `intensive_id` INT NOT NULL AUTO_INCREMENT,
  `price_per_day` DECIMAL(6,2) NULL DEFAULT '0.00',
  `hospital_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`intensive_id`),
  INDEX `hospital_id` (`hospital_id` ASC) VISIBLE,
  CONSTRAINT `intensive_cares_ibfk_1`
    FOREIGN KEY (`hospital_id`)
    REFERENCES `billing system`.`hospital` (`hospital_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`medicine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`medicine` ;

CREATE TABLE IF NOT EXISTS `billing system`.`medicine` (
  `medicine_id` INT NOT NULL AUTO_INCREMENT,
  `medicine_price` DECIMAL(6,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`medicine_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`medicine_usage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`medicine_usage` ;

CREATE TABLE IF NOT EXISTS `billing system`.`medicine_usage` (
  `patient_id` INT NOT NULL,
  `medicine_id` INT NOT NULL,
  PRIMARY KEY (`patient_id`, `medicine_id`),
  INDEX `medicine_id` (`medicine_id` ASC) VISIBLE,
  CONSTRAINT `medicine_usage_ibfk_1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `billing system`.`patient` (`patient_id`)
    ON DELETE CASCADE,
  CONSTRAINT `medicine_usage_ibfk_2`
    FOREIGN KEY (`medicine_id`)
    REFERENCES `billing system`.`medicine` (`medicine_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`normal_room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`normal_room` ;

CREATE TABLE IF NOT EXISTS `billing system`.`normal_room` (
  `room_id` INT NOT NULL AUTO_INCREMENT,
  `room_price_per_day` DECIMAL(6,2) NULL DEFAULT '0.00',
  `patient_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`),
  INDEX `patient_id` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `normal_room_ibfk_1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `billing system`.`patient` (`patient_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`operation_room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`operation_room` ;

CREATE TABLE IF NOT EXISTS `billing system`.`operation_room` (
  `operation_id` INT NOT NULL AUTO_INCREMENT,
  `room_price_per_day` DECIMAL(6,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`operation_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`patient's_billings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`patient's_billings` ;

CREATE TABLE IF NOT EXISTS `billing system`.`patient's_billings` (
  `bill_number` INT NOT NULL AUTO_INCREMENT,
  `patient_id` INT NOT NULL,
  `price_of_analysis` DECIMAL(6,2) NULL DEFAULT '0.00',
  `total_operations_price` DECIMAL(6,2) NULL DEFAULT '0.00',
  `doctors'_examinations_price` DECIMAL(6,2) NULL DEFAULT '0.00',
  `amount_paid_after_deposit` DECIMAL(6,2) NULL DEFAULT '0.00',
  `normal_room_days` DECIMAL(5,2) NULL DEFAULT '0.00',
  `health_insurance` VARCHAR(1) NULL DEFAULT 'F',
  `intensive_care_days` DECIMAL(5,2) NULL DEFAULT '0.00',
  `total_price_of_medicines` DECIMAL(6,2) NULL DEFAULT '0.00',
  `normal_room_total_price` DECIMAL(6,2) NULL DEFAULT '0.00',
  `intensive_care_total_price` DECIMAL(6,2) NULL DEFAULT '0.00',
  `total_price` DECIMAL(9,2) NULL DEFAULT '0.00',
  `paid` DECIMAL(9,2) NULL DEFAULT '0.00',
  `remaining` DECIMAL(9,2) NULL DEFAULT '0.00',
  `hospital_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`bill_number`, `patient_id`),
  INDEX `hospital_id` (`hospital_id` ASC) VISIBLE,
  CONSTRAINT `patient's_billings_ibfk_1`
    FOREIGN KEY (`hospital_id`)
    REFERENCES `billing system`.`hospital` (`hospital_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `billing system`.`surgery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billing system`.`surgery` ;

CREATE TABLE IF NOT EXISTS `billing system`.`surgery` (
  `patient_id` INT NOT NULL,
  `operation_id` INT NOT NULL,
  `surgery_price` DECIMAL(6,2) NULL DEFAULT '0.00',
  PRIMARY KEY (`patient_id`, `operation_id`),
  INDEX `operation_id` (`operation_id` ASC) VISIBLE,
  CONSTRAINT `surgery_ibfk_1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `billing system`.`patient` (`patient_id`)
    ON DELETE CASCADE,
  CONSTRAINT `surgery_ibfk_2`
    FOREIGN KEY (`operation_id`)
    REFERENCES `billing system`.`operation_room` (`operation_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
