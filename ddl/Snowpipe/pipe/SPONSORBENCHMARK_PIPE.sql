USE ROLE SS_DBA;

CREATE
OR REPLACE 
PIPE SS_DEV.RAW.SPONSORBENCHMARK_PIPE 
AUTO_INGEST = TRUE 
INTEGRATION = 'STATESTREET_INTEGRATION' 
AS COPY INTO SPONSORBENCHMARK
  (
    SPONSOR_ID,
    BENCHMARK_ID,
    BENCHMARK_OVERRIDE_NAME,
    ACTIVE_FLAG,
    SEC_ROLLUP_FLAG,
    LVL_BELOW_TOTAL_FLAG,
    SEC_DISPLAY_ALLOWED_FLAG,
    SUMMARY_REPORTING_FLG,
    SOURCE_FILENAME,
    SOURCE_FILE_ROW_NUMBER
  )
FROM
  (
    SELECT
      T.$1,
      T.$2,
      T.$3,
      T.$4,
      T.$5,
      T.$6,
      T.$7,
      T.$8,
      METADATA$FILENAME,
      METADATA$FILE_ROW_NUMBER
    FROM
      @STATESTREET_AZURE_STAGE_SPONSORBENCHMARK (FILE_FORMAT => SS_FILEFORMAT_CSV) T
  );