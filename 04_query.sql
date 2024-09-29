SELECT
    calls_ivr_id,  -- Identificador de la llamada
    CASE 
      WHEN STARTS_WITH(calls_vdn_label, 'ATC') THEN 'FRONT'
      WHEN STARTS_WITH(calls_vdn_label, 'TECH') THEN 'TECH'
      WHEN calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
      ELSE 'RESTO'
    END AS vdn_aggregation
FROM
  `keepcoding.ivr_detail`
GROUP BY 
    calls_ivr_id, calls_vdn_label;  -- Agrupamos por el identificador de la llamada y el vdn_label
