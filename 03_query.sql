CREATE TABLE keepcoding.ivr_detail AS 
  SELECT
    calls.ivr_id AS calls_ivr_id,  -- Especificamos que el ivr_id viene de la tabla calls
    calls.phone_number AS calls_phone_number,
    calls.ivr_result AS calls_ivr_result,
    calls.vdn_label AS calls_vdn_label,
    FORMAT_DATE('%Y%m%d', calls.start_date) AS calls_start_date_id,
    FORMAT_DATE('%Y%m%d', calls.end_date) AS calls_end_date_id,
    calls.total_duration AS calls_total_duration,
    calls.customer_segment AS calls_customer_segment,
    calls.ivr_language AS calls_ivr_language,
    steps_module AS calls_steps_module,
    module_aggregation,
    modules.module_name,
    modules.module_duration,
    modules.module_result, 
    steps.step_sequence,
    steps.step_name,
    steps.step_result,
    steps.step_description_error,
    steps.document_type AS step_document_type,
    steps.document_identification AS step_document_identification,
    steps.customer_phone AS step_customer_phone,
    billing_account_id
  FROM 
    keepcoding.ivr_calls AS calls
  JOIN 
    keepcoding.ivr_modules AS modules
    ON calls.ivr_id = modules.ivr_id  -- Relacionamos ivr_id de ivr_calls con ivr_modules
  JOIN 
    keepcoding.ivr_steps AS steps
    ON modules.ivr_id = steps.ivr_id  -- Relacionamos ivr_id de ivr_modules con ivr_steps
    AND modules.module_sequece = steps.module_sequece;