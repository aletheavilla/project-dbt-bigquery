with obt as (
    SELECT * FROM {{ref('stg_ops_big_table')}}
)

SELECT *
FROM obt