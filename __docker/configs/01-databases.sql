# create databases
CREATE DATABASE IF NOT EXISTS `elixir_api`;
CREATE DATABASE IF NOT EXISTS `elixir_api_test`;

# create root user and grant rights
CREATE USER 'root'@'localhost' IDENTIFIED BY 'local';
GRANT ALL ON *.* TO 'root'@'%';
