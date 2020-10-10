USE [SSISDB]
GO

-- Declaramos variables
DECLARE @RC int
DECLARE @folder_name nvarchar(128)
DECLARE @environment_name nvarchar(128)
DECLARE @variable_name nvarchar(128)
DECLARE @value sql_variant

-- Seteamos los valores de los parametros
SET @folder_name = N'Folder'
SET @environment_name = N'Test'
SET @variable_name = N'Variable'
SET @value = N'Nuevo_valor'

-- Execute the stored procedure
EXECUTE @RC = [catalog].[set_environment_variable_value] 
   @folder_name
  ,@environment_name
  ,@variable_name
  ,@value
GO

--verificar si se actualizo el valor
select * from SSISDB.internal.environment_variables
WHERE name like 'Variable'