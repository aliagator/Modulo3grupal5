/*
Parte 1: Crear entorno de trabajo
- Crear una base de datos
- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.
*/

DROP TABLE IF EXISTS `tecito`;
CREATE DATABASE `tecito`;
CREATE USER 'sammy'@'localhost' IDENTIFIED BY 'pass123';
GRANT ALL PRIVILEGES ON mydb.* TO 'sammy'@'localhost';
USE `tecito`;

/*
Parte 2: Crear dos tablas.
- La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido,
contraseña, zona horaria (por defecto UTC-3), género y teléfono de contacto).
- La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los
usuarios a la plataforma (id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto la
fecha-hora actual)).
*/

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `contrasena` varchar(45) DEFAULT NULL,
  `zonaHoraria` varchar(45) DEFAULT 'UTC-3',
  `genero` varchar(45) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `fechaHora`;
CREATE TABLE `fechaHora` (
  id_ingreso INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  fecha_hora_ingreso DATETIME DEFAULT NOW(),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

/*
Parte 3: Modificación de la tabla
- Modifique el UTC por defecto.Desde UTC-3 a UTC-2.
*/
ALTER TABLE `usuarios` ALTER COLUMN zonaHoraria SET DEFAULT 'UTC-2';

/* 
Parte 4: Creación de registros.
Para cada tabla crea 8 registros.*/

INSERT INTO `usuarios` VALUES 
(1,'alan','abarca','123456','UTC-2','hombre',99876),
(2,'elon','bolsonaro','123456','UTC-2','hombre',76654),
(3,'eliana','casas','123456','UTC-2','mujer', 987654),
(4,'julian','casablancas','123456','UTC-2','hombre',766778),
(5,'carlos','eufrates','123456','UTC-2','hombre',88765),
(6,'totoro','toro','123456','UTC-2','hombre',88765),
(7,'carlanga','colombolo','123456','UTC-2','hombre',88765),
(8,'carlos','eufrates','123456','UTC-2','hombre',88765);

INSERT INTO `fechaHora`(id_ingreso, id_usuario, fecha_hora_ingreso) VALUES
(NULL,1,NOW()),
(NULL,2,NOW()),
(NULL,3,NOW()),
(NULL,4,NOW()),
(NULL,5,NOW()),
(NULL,6,NOW()),
(NULL,7,NOW()),
(NULL,8,NOW());

/*
Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?

-En la tabla usuarios, se utiliza el tipo de dato VARCHAR para los campos de texto, 
ya que permiten almacenar valores de longitud variable (hasta 50 caracteres en este caso). 
Para la contraseña, se utiliza también VARCHAR en lugar de un tipo de dato más seguro como 
el HASH porque no se especifica el nivel de seguridad necesario. 
Se utiliza varchar para el campo genero
Para el teléfono de contacto, se utiliza VARCHAR ya que no se realizará ningún cálculo o comparación con el valor almacenado.
-- En la tabla visitantes, se utiliza el tipo de dato INT para el campo id_usuario ya que se trata de un número entero que se utiliza para relacionar con la tabla usuarios. 
Se utiliza DATETIME para el campo fecha_hora_ingreso ya que se trata de una fecha y hora específica.
*/

/*
Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono,
correo electronico).
*/
DROP TABLE IF EXISTS `contactos`;
CREATE TABLE `contactos` (
  id_contacto INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  telefono INT DEFAULT NULL,
  email VARCHAR(30) DEFAULT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
/*
Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la
tabla Contactos.
*/
ALTER TABLE `usuarios`
ADD COLUMN `id_contacto` INT NOT NULL PRIMARY KEY,
ADD FOREIGN KEY (id_contacto) REFERENCES contactos(id_contacto);