SELECT calls_ivr_id,
       CASE 
           WHEN MAX(CASE WHEN step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK' THEN 1 ELSE 0 END) = 1 
           THEN 1
           ELSE 0
       END AS info_by_dni_lg
-- Generamos el campo info_by_dni_lg: si pasa por el step CUSTOMERINFOBYDNI.TX y el resultado es OK, asignamos 1; de lo contrario, 0
FROM keepcoding.ivr_detail
GROUP BY calls_ivr_id
-- Agrupamos por identificador de llamada para tener un registro por llamada
ORDER BY calls_ivr_id;
-- Ordenamos los resultados por identificador de llamada

