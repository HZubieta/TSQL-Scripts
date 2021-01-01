SELECT CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server, 
   msdb.dbo.backupset.database_name,  
   msdb.dbo.backupset.backup_start_date,  
   --msdb.dbo.backupset.backup_finish_date, 
   --DATEDIFF(MI,msdb.dbo.backupset.backup_start_date,msdb.dbo.backupset.backup_finish_date)/60.0 AS [Estimated_Duration],
   --msdb.dbo.backupset.expiration_date, 
   CASE msdb..backupset.type
       WHEN 'D' THEN 'Full'  
       WHEN 'L' THEN 'Log'
       WHEN 'I' THEN 'Differential'
       WHEN 'F' THEN 'File or Filegroup'    END AS backup_type,
   ((msdb.dbo.backupset.backup_size/1024.00)/1024.00) as backup_size_MB,  
   msdb.dbo.backupmediafamily.logical_device_name,  
   msdb.dbo.backupmediafamily.physical_device_name,   
   msdb.dbo.backupset.name AS backupset_name,
   msdb.dbo.backupset.description
FROM   msdb.dbo.backupmediafamily 
   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
WHERE  (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) >= GETDATE() - 1000) --AND database_name = 'DB_name' 
AND msdb..backupset.type NOT LIKE 'L'
--AND DATABASE_NAME NOT IN ('MASTER','MODEL','MSDB')
--AND msdb.dbo.backupset.name LIKE 'Backup Exec SQL Server Agent'
AND DATABASE_NAME IN ('DB_name')
--and database_name like 'DB_name'
--AND year(msdb.dbo.backupset.backup_start_date) = 2016 
--AND month(msdb.dbo.backupset.backup_start_date) = 6
--AND physical_device_name > ''
ORDER BY
  -- msdb.dbo.backupset.database_name, 
msdb.dbo.backupset.backup_start_date DESC

