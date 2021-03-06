USE SCHEMA CURRENT_RAW;

CREATE OR REPLACE VIEW TRANSACTIONS 
COMMENT = 'VIEW TO FETCH THE MOST RECENT RECORDS' 
AS
SELECT
SPONSOR_ID,
TRANSACTION_TYPE_CODE,
TRANSACTION_SUB_TYPE_CODE,
CASH_FLOW_CATEGORY_NAME,
COMMITMENT_TYPE_DESCRIPTION,
CURRENCY_LOCAL_CODE,
ENTITY_CODE,
ASSET_IDENTIFIER,
COUPON_RATE,
MATURITY_DATE,
UNIQUE_SECURITY_ID,
EFFECTIVE_DATE,
SETTLEMENT_DATE_CONTRACTUAL,
UNIT_PRICE,
UNITS_AMOUNT,
NET_LOCAL_AMOUNT,
TRADE_DATE_LOCAL_EXCHANGE_RATE,
COMMITMENT_EXCLUDED,
RECALLABLE_AMOUNT,
CASH_OR_STOCK,
INTEREST_BOUGHT_SOLD_LOCAL_AMOUNT,
SOURCE_TRADE_IDENTIFIER,
TRANSACTION_IDENTIFIER,
SOURCE,
TRANS_CODE_KEY,
REVERSAL_KEY_AIS,
SOURCE_FILENAME,
INGESTION_TIME
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER(
                PARTITION BY TRANS_CODE_KEY -- check the correctness of column used
                ORDER BY
                    INGESTION_TIME DESC
            ) AS RN
        FROM
            RAW.TRANSACTIONS
    )
WHERE
    RN = 1
ORDER BY
    TRANS_CODE_KEY,
    INGESTION_TIME;