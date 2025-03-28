-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema min_bildeling_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema min_bildeling_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `min_bildeling_db` ;
USE `min_bildeling_db` ;

-- -----------------------------------------------------
-- Table `min_bildeling_db`.`Bruker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `min_bildeling_db`.`Bruker` (
  `Bruker_id` INT NOT NULL AUTO_INCREMENT,
  `Fornavn` VARCHAR(45) NOT NULL,
  `Etternavn` VARCHAR(45) NOT NULL,
  `Tlf` CHAR(8) NOT NULL,
  `Mail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Bruker_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `min_bildeling_db`.`Bil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `min_bildeling_db`.`Bil` (
  `Reg_nr` VARCHAR(7) NOT NULL,
  `Bruker_id` INT NOT NULL,
  `Merke` VARCHAR(45) NOT NULL,
  `Modell` VARCHAR(45) NOT NULL,
  `Årsmodell` DECIMAL(4) NOT NULL,
  `Effekt` DECIMAL NOT NULL,
  `Hjuldrift` VARCHAR(45) NOT NULL,
  `Kjøretøy_type` VARCHAR(45) NOT NULL,
  `Kjæledyr_tillatt` TINYINT NOT NULL,
  `Røyking_tillatt` TINYINT NOT NULL,
  `Pris_per_døgn` INT NOT NULL,
  `Drivlinje` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Reg_nr`),
  INDEX `fk_Bil_Bruker_idx` (`Bruker_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bil_Bruker`
    FOREIGN KEY (`Bruker_id`)
    REFERENCES `min_bildeling_db`.`Bruker` (`Bruker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `min_bildeling_db`.`Postnummer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `min_bildeling_db`.`Postnummer` (
  `Postnummer` CHAR(4) NOT NULL,
  `Poststed` VARCHAR(45) NULL,
  PRIMARY KEY (`Postnummer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `min_bildeling_db`.`Adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `min_bildeling_db`.`Adresse` (
  `Adresse_id` INT NOT NULL AUTO_INCREMENT,
  `Bruker_id` INT NOT NULL,
  `Adresse_type` VARCHAR(45) NOT NULL,
  `Gate` VARCHAR(45) NOT NULL,
  `Gatenummer` VARCHAR(7) NOT NULL,
  `Postnummer` CHAR(4) NOT NULL,
  PRIMARY KEY (`Adresse_id`),
  INDEX `Adresse_Bruker_fn_idx` (`Bruker_id` ASC) VISIBLE,
  INDEX `Adresse_Popstnummer_fk_idx` (`Postnummer` ASC) VISIBLE,
  CONSTRAINT `Adresse_Bruker_fk`
    FOREIGN KEY (`Bruker_id`)
    REFERENCES `min_bildeling_db`.`Bruker` (`Bruker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Adresse_Popstnummer_fk`
    FOREIGN KEY (`Postnummer`)
    REFERENCES `min_bildeling_db`.`Postnummer` (`Postnummer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `min_bildeling_db`.`Booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `min_bildeling_db`.`Booking` (
  `Booking_id` INT NOT NULL AUTO_INCREMENT,
  `Reg_nr` VARCHAR(7) NOT NULL,
  `Utleier` INT NOT NULL,
  `Leietaker` INT NOT NULL,
  `Dato_fra` DATE NOT NULL,
  `Dato_til` DATE NOT NULL,
  `Henteadresse` INT NOT NULL,
  `Innleveringsadresse` INT NOT NULL,
  `Karakter_utleier` DECIMAL(1) NULL,
  `Karakter_leietaker` DECIMAL(1) NULL,
  `Kilometerstand_før` INT NULL,
  `Kilometerstand_etter` INT NULL,
  `Kommentar` VARCHAR(200) NULL,
  PRIMARY KEY (`Booking_id`),
  INDEX `fn_Booking_Bil_idx` (`Reg_nr` ASC) VISIBLE,
  INDEX `Booking_Adresse_fn_idx` (`Henteadresse` ASC) VISIBLE,
  INDEX `Booking_Bruker_fk_idx` (`Utleier` ASC) VISIBLE,
  INDEX `booking_Bruker_fk2_idx` (`Leietaker` ASC) VISIBLE,
  INDEX `Booking_Adresse_fk2_idx` (`Innleveringsadresse` ASC) VISIBLE,
  CONSTRAINT `Booking_Bil_fk`
    FOREIGN KEY (`Reg_nr`)
    REFERENCES `min_bildeling_db`.`Bil` (`Reg_nr`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Booking_Adresse_fk1`
    FOREIGN KEY (`Henteadresse`)
    REFERENCES `min_bildeling_db`.`Adresse` (`Adresse_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Booking_Bruker_fk1`
    FOREIGN KEY (`Utleier`)
    REFERENCES `min_bildeling_db`.`Bruker` (`Bruker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `booking_Bruker_fk2`
    FOREIGN KEY (`Leietaker`)
    REFERENCES `min_bildeling_db`.`Bruker` (`Bruker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Booking_Adresse_fk2`
    FOREIGN KEY (`Innleveringsadresse`)
    REFERENCES `min_bildeling_db`.`Adresse` (`Adresse_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `min_bildeling_db`.`Melding`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `min_bildeling_db`.`Melding` (
  `Melding_id` INT NOT NULL AUTO_INCREMENT,
  `Avsender` INT NOT NULL,
  `Mottaker` INT NOT NULL,
  `Svar_på` INT NULL,
  `Innhold` LONGTEXT NULL,
  `Booking_id` INT NULL,
  `Tidspunkt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Melding_id`),
  INDEX `Melding_Bruker_db_idx` (`Avsender` ASC) VISIBLE,
  INDEX `Melding_Booking_fk_idx` (`Booking_id` ASC) VISIBLE,
  INDEX `Melding_Melding_fk_idx` (`Svar_på` ASC) VISIBLE,
  INDEX `Melding_Bruker_fk2_idx` (`Mottaker` ASC) VISIBLE,
  CONSTRAINT `Melding_Bruker_fk1`
    FOREIGN KEY (`Avsender`)
    REFERENCES `min_bildeling_db`.`Bruker` (`Bruker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Melding_Booking_fk`
    FOREIGN KEY (`Booking_id`)
    REFERENCES `min_bildeling_db`.`Booking` (`Booking_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Melding_Melding_fk`
    FOREIGN KEY (`Svar_på`)
    REFERENCES `min_bildeling_db`.`Melding` (`Melding_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `Melding_Bruker_fk2`
    FOREIGN KEY (`Mottaker`)
    REFERENCES `min_bildeling_db`.`Bruker` (`Bruker_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
