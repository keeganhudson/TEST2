
SELECT
    PRIMARY_KEY AS EXCHANGE_RATE_KEY,
    {{ ref('CURRENCY_PAIR_DIM') }}.CURRENCY_PAIR_KEY,
    TO_VARCHAR(EFFECTIVE_DATE,'YYYYMMDD')::INT AS DATE_KEY,
    SPOT_RATE AS EXCHANGE_RATE,
    POW(SPOT_RATE, -1) AS RECIPROCAL_EXCHANGE_RATE,
    SOURCE_FILENAME AS LINEAGEKEY,
    DBT_VALID_FROM AS VALIDFROM,
    DBT_VALID_TO AS VALIDTO,
    {{ ref('DATA_SOURCE_DIM') }}.DATA_SOURCE_KEY
FROM {{ ref('FXRATES_SNAPSHOT') }}
JOIN {{ ref('CURRENCY_PAIR_DIM') }} ON {{ ref('CURRENCY_PAIR_DIM') }}.PAIR_NAME = {{ ref('FXRATES_SNAPSHOT') }}.CURRENCY_PAIR_CODE
JOIN {{ ref('DATA_SOURCE_DIM') }} ON {{ ref('DATA_SOURCE_DIM') }}.DATA_SOURCE_NAME = {{ ref('FXRATES_SNAPSHOT') }}.EXCHANGE_SOURCE_CODE