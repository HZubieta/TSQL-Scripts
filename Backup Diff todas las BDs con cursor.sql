DECLARE @name VARCHAR(50) -- Nombre de la BD 
DECLARE @path VARCHAR(256) -- Ruta de Backup
DECLARE @fileName VARCHAR(256) -- Nombre de archivo  
DECLARE @fileDate VARCHAR(20) -- Fecha para nombre de archivo 

SET @path = 'G:\Bcksql\'  

SELECT @fileDate = convert(nvarchar,getdate(),112) 

DECLARE db_cursor CURSOR FOR  
SELECT name 
FROM MASTER.dbo.sysdatabases 
WHERE name NOT IN ('master','model','msdb','tempdb')  

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name

WHILE @@FETCH_STATUS = 0
BEGIN   
       SET @fileName = @path + @name + '_DIFF_' + @fileDate + '.bak'  
       BACKUP DATABASE @name TO DISK = @fileName  
	   WITH  DIFFERENTIAL , NOFORMAT, NOINIT,
	   NAME = N'Differential Database Backup',
       SKIP, NOREWIND, NOUNLOAD,  STATS = 10, CHECKSUM
	   declare @backupSetId as int
	   select @backupSetId = position from msdb..backupset where database_name=@name and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=@name )
	   if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database'' + @name + ''not found.', 16, 1) end
       RESTORE VERIFYONLY FROM  DISK = @fileName WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND 
       FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor