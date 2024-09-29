-- Creamos la tabla ivr_summary en el dataset keepcoding
CREATE TABLE keepcoding.ivr_summary AS
WITH detail_data AS (
  -- Seleccionamos y calculamos los campos necesarios desde ivr_detail y los ejercicios anteriores
  SELECT
    calls_ivr_id AS ivr_id,                    -- Identificador de la llamada
    calls_phone_number AS phone_number,        -- Número del llamante
    calls_ivr_result AS ivr_result,            -- Resultado de la llamada
    -- Campo calculado vdn_aggregation
    CASE 
      WHEN calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
      WHEN calls_vdn_label LIKE 'TECH%' THEN 'TECH'
      WHEN calls_vdn_label LIKE 'ABSORPTION%' THEN 'ABSORPTION'
      ELSE 'RESTO'
    END AS vdn_aggregation,
    -- Fecha de inicio de la llamada (parseada si es necesario)
    PARSE_TIMESTAMP('%Y%m%d', CAST(calls_start_date_id AS STRING)) AS start_date,
    -- Fecha de fin de la llamada (parseada si es necesario)
    PARSE_TIMESTAMP('%Y%m%d', CAST(calls_end_date_id AS STRING)) AS end_date,
    -- Duración total de la llamada (en segundos o minutos)
    calls_total_duration AS total_duration,
    -- Segmento del cliente
    calls_customer_segment AS customer_segment,
    -- Idioma de la IVR
    calls_ivr_language AS ivr_language,
    -- Número de módulos por los que pasa la llamada
    COUNT(DISTINCT module_sequence) AS steps_module,
    -- Lista de módulos por los que pasa la llamada (concatenación)
    STRING_AGG(DISTINCT module_name, ', ') AS module_aggregation,
    -- Documento de identificación del cliente
    MAX(step_document_type) AS document_type,
    MAX(step_document_identification) AS document_identification,
    -- Número de teléfono del cliente identificado en la llamada
    MAX(step_customer_phone) AS customer_phone,
    -- Calculado anteriormente: billing_account_id
    MAX(step_document_identification) AS billing_account_id,
    -- Flag calculado: masiva_lg
    MAX(CASE WHEN module_name = 'AVERIA_MASIVA' THEN 1 ELSE 0 END) AS masiva_lg,
    -- Flag calculado: info_by_phone_lg
    MAX(CASE WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_result = 'OK' THEN 1 ELSE 0 END) AS info_by_phone_lg,
    -- Flag calculado: info_by_dni_lg
    MAX(CASE WHEN step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK' THEN 1 ELSE 0 END) AS info_by_dni_lg
  FROM keepcoding.ivr_detail
  GROUP BY calls_ivr_id, calls_phone_number, calls_ivr_result, calls_vdn_label, calls_start_date_id, calls_end_date_id, 
           calls_total_duration, calls_customer_segment, calls_ivr_language
),
phone_calls_summary AS (
  -- Aquí calculamos los campos repeated_phone_24H y cause_recall_phone_24H usando el código anterior
  SELECT 
    calls_ivr_id,
    -- Flag para llamadas en las 24 horas anteriores
    IF(LAG(PARSE_TIMESTAMP('%Y%m%d', CAST(calls_start_date_id AS STRING))) 
        OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date_id) IS NOT NULL 
        AND TIMESTAMP_DIFF(PARSE_TIMESTAMP('%Y%m%d', CAST(calls_start_date_id AS STRING)),
                           LAG(PARSE_TIMESTAMP('%Y%m%d', CAST(calls_start_date_id AS STRING))) 
                           OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date_id), HOUR) <= 24, 1, 0) AS repeated_phone_24H,
    -- Flag para llamadas en las 24 horas siguientes
    IF(LEAD(PARSE_TIMESTAMP('%Y%m%d', CAST(calls_start_date_id AS STRING))) 
        OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date_id) IS NOT NULL 
        AND TIMESTAMP_DIFF(LEAD(PARSE_TIMESTAMP('%Y%m%d', CAST(calls_start_date_id AS STRING))) 
                           OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date_id),
                           PARSE_TIMESTAMP('%Y%m%d', CAST(calls_start_date_id AS STRING)), HOUR) <= 24, 1, 0) AS cause_recall_phone_24H
  FROM keepcoding.ivr_detail
)
-- Finalmente unimos los datos y creamos la tabla final
SELECT 
  d.ivr_id,
  d.phone_number,
  d.ivr_result,
  d.vdn_aggregation,
  d.start_date,
  d.end_date,
  d.total_duration,
  d.customer_segment,
  d.ivr_language,
  d.steps_module,
  d.module_aggregation,
  d.document_type,
  d.document_identification,
  d.customer_phone,
  d.billing_account_id,
  d.masiva_lg,
  d.info_by_phone_lg,
  d.info_by_dni_lg,
  p.repeated_phone_24H,
  p.cause_recall_phone_24H
FROM detail_data d
LEFT JOIN phone_calls_summary p ON d.ivr_id = p.calls_ivr_id
ORDER BY d.ivr_id;


