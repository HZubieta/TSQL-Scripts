SELECT smf.name AS InternalName
, smf.physical_name AS PhysicalFile
, smf.type_desc AS FileType
, CONVERT(NUMERIC(15,0), ((io_stall_read_ms / num_of_reads)
+ (io_stall_write_ms / num_of_writes)) / 2) AS AverageWait_ms
FROM sys.dm_io_virtual_file_stats(NULL, NULL) svs
INNER JOIN sys.master_files smf ON svs.database_id = smf.database_id
AND svs.file_id = smf.file_id
AND SMF.NAME  = 'DB_name'
ORDER BY AverageWait_ms DESC


SELECT * FROM SYS.MASTER_FILES