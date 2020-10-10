USE [msdb]
GO

--Crea alerta para tamaño de Log > 5 GB
EXEC msdb.dbo.sp_add_alert @name=N'Log de DB > 5GB', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=0, 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'Base de Datos|Tamaño de Log File(s) (KB)|DBNAME|>|5242880', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO


