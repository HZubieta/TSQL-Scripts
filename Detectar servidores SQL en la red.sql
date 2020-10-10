EXEC sp_configure 'show advanced options', 1 
GO 
RECONFIGURE 
GO 
EXEC sp_configure 'xp_cmdshell', 1
GO 
RECONFIGURE
GO 
EXEC sp_configure 'xp_cmdshell', 0
GO 
RECONFIGURE
EXEC sp_configure 'show advanced options', 0
GO

EXEC master..XP_CMDShell 'OSQL -L' 