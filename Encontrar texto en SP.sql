
--buscar un string en todos los SP de una BD
select distinct object_name(id) as Object
from syscomments 
where text like '%string_buscado%'

--ver definicion del SP encontrado
SP_HELPTEXT sp_name