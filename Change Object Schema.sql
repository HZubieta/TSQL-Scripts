/* Works in SQL Server and Azure SQL Database and Managed Instance.
  NewSchema is the schema the object will be transferred to.
  Can also be used to move sprocs, views, functions, triggers, etc.*/

Use AdventureWorks2016
GO
ALTER SCHEMA NewSchema TRANSFER [dbo].[DropIndexes];