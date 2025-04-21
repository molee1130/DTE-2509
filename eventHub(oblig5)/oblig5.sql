-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Bruker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bruker` (
  `idBruker` INT NOT NULL AUTO_INCREMENT,
  `fornavn` VARCHAR(45) NOT NULL,
  `etternavn` VARCHAR(45) NOT NULL,
  `epost` VARCHAR(45) NOT NULL,
  `passord` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idBruker`),
  UNIQUE INDEX `epost_UNIQUE` (`epost` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Arrangement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Arrangement` (
  `idArrangement` INT NOT NULL AUTO_INCREMENT,
  `arrangementAnsvarlig` INT NOT NULL,
  `tittel` VARCHAR(45) NULL,
  `tidspunkt` DATETIME NULL,
  `sted` VARCHAR(45) NULL,
  `beskrivelse` VARCHAR(500) NULL,
  PRIMARY KEY (`idArrangement`),
  INDEX `arr_ansvarlig_idBrukerFK_idx` (`arrangementAnsvarlig` ASC) VISIBLE,
  CONSTRAINT `arr_ansvarlig_idBrukerFK`
    FOREIGN KEY (`arrangementAnsvarlig`)
    REFERENCES `mydb`.`Bruker` (`idBruker`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Påmelding`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Påmelding` (
  `idArrangement` INT NOT NULL,
  `idBruker` INT NOT NULL,
  PRIMARY KEY (`idArrangement`, `idBruker`),
  INDEX `brukerPåmeldingFK_idx` (`idBruker` ASC) VISIBLE,
  CONSTRAINT `brukerPåmeldingFK`
    FOREIGN KEY (`idBruker`)
    REFERENCES `mydb`.`Bruker` (`idBruker`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `arrangementPåmeldingFK`
    FOREIGN KEY (`idArrangement`)
    REFERENCES `mydb`.`Arrangement` (`idArrangement`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
