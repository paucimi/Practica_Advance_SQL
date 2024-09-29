SELECT calls_ivr_id,
       CASE 
           WHEN MAX(CASE WHEN module_name = 'AVERIA_MASIVA' THEN 1 ELSE 0 END) = 1 
           THEN 1
           ELSE 0
       END AS masiva_lg
-- Generamos el campo masiva_lg: si la llamada pasó por el módulo AVERIA_MASIVA, asignamos 1; de lo contrario, 0
FROM keepcoding.ivr_detail
GROUP BY calls_ivr_id
-- Agrupamos por llamada para tener un registro por llamada
ORDER BY calls_ivr_id;
-- Ordenamos por identificador de llamada para mejor visualización