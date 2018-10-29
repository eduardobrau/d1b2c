CREATE DATABASE IF NOT EXISTS `app_php` DEFAULT CHARACTER SET utf8 ;
USE `app_php` ;

-- -----------------------------------------------------
-- Table `app_php`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `app_php`.`usuarios` (
  `id` VARCHAR(100) NOT NULL,
  `usuario` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `email` VARCHAR(145) NOT NULL,
  `data_cadastro` DATETIME NOT NULL DEFAULT NOW(),
  `ultimo_acesso` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
PACK_KEYS = DEFAULT;

INSERT INTO `app_php`.`usuarios` (`id`, `usuario`, `senha`, `email`, `data_cadastro`) 
VALUES 
('454545', 'larissa', '123', 'lari@gmail.com', '2018-10-02 20:22:56'),
('34345', 'João', '123', 'joao@gmail.com', '2018-10-06 20:22:56');

-- -----------------------------------------------------
-- Table `app_php`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `app_php`.`perfil` (
  `id` VARCHAR(100) NOT NULL,
  `nome` VARCHAR(145) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `data_nascimento` DATETIME NOT NULL,
  `telefone` MEDIUMTEXT NOT NULL,
  `endereco` VARCHAR(145) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `cep` VARCHAR(15) NULL,
  `usuario_id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`, `usuario_id`),
  INDEX `idx_usuario_id` (`usuario_id`),
  CONSTRAINT `fk_usuario_id`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `app_php`.`usuarios` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;