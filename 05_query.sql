SELECT
    calls_ivr_id,
    CASE 
      WHEN MAX(step_document_type) IS NOT NULL AND MAX(step_document_identification) IS NOT NULL 
      THEN CONCAT(MAX(step_document_type), ' : ', MAX(step_document_identification)) 
      ELSE NULL  -- Si uno de los dos es NULL, mostramos NULL
    END AS document_info  -- La columna concatenada
FROM
    `keepcoding.ivr_detail`
GROUP BY
    calls_ivr_id
ORDER BY
    calls_ivr_id;