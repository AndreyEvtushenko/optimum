CREATE USER 'optimum_sys'@'%' IDENTIFIED WITH mysql_native_password BY 'Let_me_in2';
GRANT UPDATE, DELETE, SELECT, EXECUTE, INSERT on optimum.* TO 'optimum_sys'@'%';
EXIT