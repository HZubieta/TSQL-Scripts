--Detectar jobs que no tienen un operador configurado
--Es posible que si el job falla no tenga a quien alertar
SELECT NAME, notify_email_operator_id 
FROM MSDB.DBO.SYSJOBS
WHERE NOTIFY_EMAIL_OPERATOR_ID = 0
ORDER BY NAME ASC