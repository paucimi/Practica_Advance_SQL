SELECT calls_ivr_id, 
       MAX(step_document_identification) AS billing_account_id
-- Seleccionamos el número de identificación del cliente, que será tratado como billing_account_id
FROM keepcoding.ivr_detail
GROUP BY calls_ivr_id
-- Agrupamos por llamada (calls_ivr_id) para asegurarnos de tener un solo registro por llamada
HAVING MAX(step_document_identification) IS NOT NULL
-- Solo devolvemos registros donde se ha identificado el cliente (billing_account_id)
ORDER BY calls_ivr_id;
-- Ordenamos los resultados por el identificador de la llamada
