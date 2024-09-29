WITH phone_calls AS (
  SELECT 
    calls_ivr_id,
    calls_phone_number,
    calls_start_date_id, 
    -- Convertimos calls_start_date_id a formato TIMESTAMP para poder comparar intervalos en horas
    PARSE_TIMESTAMP('%Y%m%d', CAST(calls_start_date_id AS STRING)) AS calls_start_timestamp,
    LEAD(PARSE_TIMESTAMP('%Y%m%d', CAST(calls_start_date_id AS STRING)), 1) 
        OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date_id) AS next_call,
    LAG(PARSE_TIMESTAMP('%Y%m%d', CAST(calls_start_date_id AS STRING)), 1) 
        OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date_id) AS prev_call
  FROM keepcoding.ivr_detail
)
SELECT 
  calls_ivr_id,
  -- Flag para llamadas en las 24 horas anteriores
  IF(prev_call IS NOT NULL AND TIMESTAMP_DIFF(calls_start_timestamp, prev_call, HOUR) <= 24, 1, 0) AS repeated_phone_24H,
  -- Flag para llamadas en las 24 horas siguientes
  IF(next_call IS NOT NULL AND TIMESTAMP_DIFF(next_call, calls_start_timestamp, HOUR) <= 24, 1, 0) AS cause_recall_phone_24H
FROM phone_calls
ORDER BY calls_ivr_id;
