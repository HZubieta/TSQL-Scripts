EXEC sys.sp_cdc_add_job @job_type = N'capture';
GO

EXEC sys.sp_cdc_add_job  
     @job_type = N'cleanup'  
    ,@start_job = 0  
    ,@retention = 4320;  