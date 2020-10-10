
-- EJEMPLO SIN TABLA TEMPORAL
SELECT event_time, action_id, session_server_principal_name, server_instance_name, database_name, object_name, statement
FROM fn_get_audit_file('D:\SQLAudit\FILE.sqlaudit', 
default, default)
WHERE action_id = 'LGIF' --CODIGO PARA FILTRAR INICIOS DE SESION FALLIDOS

/*Puedes encontrar la lista de todos los posibles códigos de action_id aqui: https://cprovolt.wordpress.com/2013/08/02/sql-server-audit-action_id-list/ */

--EJEMPLO CON TABLA TEMPORAL, PARA FLEXIBILIDAD EN LAS CONSULTAS

SELECT event_time, action_id, session_server_principal_name, server_instance_name, database_name, object_name, statement
INTO Audit_file
FROM fn_get_audit_file('D:\SQLAudit\FILE.sqlaudit', 
default, default) 

SELECT AF.event_time, DMAC.name, AF.session_server_principal_name, AF.server_instance_name, AF.database_name, AF.object_name, AF.statement
FROM Audit_file AF
INNER JOIN sys.dm_audit_actions DMAC ON DMAC.action_id = AF.action_id
WHERE STATEMENT LIKE '%RESTORE%' --Para encontrar un evento de restore