
-- Seleccionamos el número de teléfono del cliente para cada llamada
SELECT
    calls_ivr_id,
    MAX(step_customer_phone) AS customer_phone  -- Seleccionamos el número de teléfono informado
FROM
    `keepcoding.ivr_detail`
GROUP BY
    calls_ivr_id  -- Agrupamos por llamada
HAVING
    MAX(step_customer_phone) IS NOT NULL  -- Solo devolvemos registros donde hay un número de teléfono informado
ORDER BY
    calls_ivr_id;  -- Ordenamos por llamada