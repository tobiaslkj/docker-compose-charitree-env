-- MySQL Script generated by MySQL Workbench
-- Fri Nov  2 14:43:10 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Charitree
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Charitree
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Charitree` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Charitree` ;

-- -----------------------------------------------------
-- Table `Charitree`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Charitree`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(40) NOT NULL,
  `first_name` VARCHAR(20) NULL,
  `last_name` VARCHAR(20) NULL,
  `password` VARCHAR(80) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Charitree`.`CampaignManager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Charitree`.`CampaignManager` (
  `cid` INT NOT NULL,
  `UEN` VARCHAR(10) NULL,
  `organization_name` VARCHAR(45) NULL,
  PRIMARY KEY (`cid`),
  INDEX `fk_CampaignManager_User1_idx` (`cid` ASC),
  CONSTRAINT `fk_CampaignManager_User1`
    FOREIGN KEY (`cid`)
    REFERENCES `Charitree`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Charitree`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Charitree`.`Address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street_name` VARCHAR(45) NULL,
  `unit` VARCHAR(10) NULL,
  `zip` VARCHAR(6) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Address_User1_idx` (`user_id` ASC),
  CONSTRAINT `fk_Address_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Charitree`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Charitree`.`Campaign`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Charitree`.`Campaign` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `start_time` INT NULL,
  `end_time` INT NULL,
  `description` VARCHAR(255) NULL,
  `collection_point` VARCHAR(45) NULL,
  `postal_code` VARCHAR(10) NULL,
  `cid` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Campaign_CampaignManager1_idx` (`cid` ASC),
  CONSTRAINT `fk_Campaign_CampaignManager1`
    FOREIGN KEY (`cid`)
    REFERENCES `Charitree`.`CampaignManager` (`cid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Charitree`.`Donation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Charitree`.`Donation` (
  `did` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(20) NULL,
  `volunteer_name` VARCHAR(45) NULL,
  `volunteer_HP` VARCHAR(8) NULL,
  `pickup_date` VARCHAR(45) NULL,
  `pickup_time` VARCHAR(45) NULL,
  `Campaign_id` INT NOT NULL,
  `User_id` INT NOT NULL,
  `Address_id` INT NOT NULL,
  PRIMARY KEY (`did`),
  INDEX `fk_Donation_Campaign1_idx` (`Campaign_id` ASC),
  INDEX `fk_Donation_User1_idx` (`User_id` ASC),
  INDEX `fk_Donation_Address1_idx` (`Address_id` ASC),
  CONSTRAINT `fk_Donation_Campaign1`
    FOREIGN KEY (`Campaign_id`)
    REFERENCES `Charitree`.`Campaign` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Donation_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `Charitree`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Donation_Address1`
    FOREIGN KEY (`Address_id`)
    REFERENCES `Charitree`.`Address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Charitree`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Charitree`.`Item` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Charitree`.`Session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Charitree`.`Session` (
  `session_id` INT NOT NULL AUTO_INCREMENT,
  `session_token` VARCHAR(60) NULL,
  `session_expire` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`session_id`),
  INDEX `fk_Session_User1_idx` (`user_id` ASC),
  CONSTRAINT `fk_Session_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Charitree`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Charitree`.`Campaign_has_Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Charitree`.`Campaign_has_Item` (
  `Campaign_id` INT NOT NULL,
  `Item_id` INT NOT NULL,
  PRIMARY KEY (`Campaign_id`, `Item_id`),
  INDEX `fk_Campaign_has_Item_Item1_idx` (`Item_id` ASC),
  INDEX `fk_Campaign_has_Item_Campaign1_idx` (`Campaign_id` ASC),
  CONSTRAINT `fk_Campaign_has_Item_Campaign1`
    FOREIGN KEY (`Campaign_id`)
    REFERENCES `Charitree`.`Campaign` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Campaign_has_Item_Item1`
    FOREIGN KEY (`Item_id`)
    REFERENCES `Charitree`.`Item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Charitree`.`Donation_has_Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Charitree`.`Donation_has_Item` (
  `Donation_did` INT NOT NULL,
  `Item_id` INT NOT NULL,
  `qty` INT NULL,
  PRIMARY KEY (`Donation_did`, `Item_id`),
  INDEX `fk_Donation_has_Item1_Item1_idx` (`Item_id` ASC),
  INDEX `fk_Donation_has_Item1_Donation1_idx` (`Donation_did` ASC),
  CONSTRAINT `fk_Donation_has_Item1_Donation1`
    FOREIGN KEY (`Donation_did`)
    REFERENCES `Charitree`.`Donation` (`did`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Donation_has_Item1_Item1`
    FOREIGN KEY (`Item_id`)
    REFERENCES `Charitree`.`Item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- ----------------------------------------------------------
-- ------------------------TEST DATA-------------------------
-- ----------------------------------------------------------
INSERT INTO `Item`(`id`, `name`) VALUES (1,"Newspaper"),
(2,"Glass"),
(3,"Cardboard"),
(4,"Toys"),
(5,"Furniture"),
(6,"Plastic"),
(7,"Metals");