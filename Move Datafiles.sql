
--Primero, ponemos la base offline

ALTER DATABASE database_name SET OFFLINE;

--Movemos los archivos .mdf o .ndf a la ubicacion deseada
--y por cada archivo movido ejecutamos lo siguiente

ALTER DATABASE database_name MODIFY FILE ( NAME = logical_name, FILENAME = 'nueva_ubicacion\nombre_archivo' );

--Volvemos a poner la base ONLINE

ALTER DATABASE database_name SET ONLINE;

--Podemos verificar el cambio de ubicacion con esto

 SELECT name, physical_name AS CurrentLocation, state_desc
FROM sys.master_files
WHERE database_id = DB_ID(N'<database_name>');
