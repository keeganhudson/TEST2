
SELECT 
    SPONSOR_ID AS CLIENT_KEY,
    ENTITY_STATUS_CODE AS ACCOUNTSTATUS,
    SPECIAL_ENTITY_TYPE AS ACCOUNTTYPE,
    CURRENCY_BASE_CODE AS CURRENCY,
    {{ ref('FUND_STATUS_DIM') }}.FUND_STATUS_KEY AS FUND_STATUS_KEY,
    ENTITY_CODE AS EXTERNAL_FUND_ID,
    ENTITY_NAME AS FUND_NAME,
    ENTITY_SHORT_NAME AS FUND_SHORT_NAME,
    MNTHLY_PERF_EST_METHOD AS MONTHLY_PERF_EST_METHOD,
    INCEPTION_DATE AS INCEPTION_DATE,
    ENTITY_VALUE_EST_METHOD AS ENTITY_VALUE_EST_METHOD,
    COMMINGLED_FLG,
    DAILY_PERF_FLG,
    DAILY_PERF_CNVRSN_DT AS DAILY_PERF_CONVERSION_DATE,
    CLOSE_DATE_PERFORMANCE AS PERF_CLOSE_DATE,
    INCEPTION_DT_GASB,
    FISCAL_YEAR_END_MNTH,
    SOURCE_FILENAME AS LINEAGEKEY,
    DBT_VALID_FROM AS VALIDFROM,
    DBT_VALID_TO AS VALIDTO

FROM {{ ref('accountprofile_snapshot') }}
JOIN {{ ref('FUND_STATUS_DIM') }} ON {{ ref('FUND_STATUS_DIM') }}.FUND_STATUS_NAME = {{ ref('accountprofile_snapshot') }}.ENTITY_STATUS_CODE