-- models/staging/stg_customers.sql

with source as (
    -- Referencia a la tabla raw de clientes definida en tu src_olist.yml
    select * from {{ source('raw_data', 'customers') }}
),

transformed as (
    select
        -- Identificadores únicos
        customer_id,
        customer_unique_id,

        -- 1. Código postal convertido a VARCHAR(10)
        cast(customer_zip_code_prefix as varchar(10)) as customer_zip_code_prefix,

        -- 2. Ciudad en Upper Camel Case y sin espacios extra
        initcap(trim(customer_city)) as customer_city,

        -- 3. Estado (usualmente son siglas de 2 letras, las dejamos en mayúsculas)
        upper(customer_state) as customer_state

    from source
)

select * from transformed