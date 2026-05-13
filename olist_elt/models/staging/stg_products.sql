-- models/staging/stg_products.sql

with source as (
    select * from {{ source('raw_data', 'products') }}
),

transformed as (
    select
        -- Identificador único
        product_id,

        -- Limpieza de categoría: Quitamos guiones bajos, espacios y corregimos nulos
        case 
            when product_category_name is null then 'Sin Categoria'
            else initcap(trim(replace(product_category_name, '_', ' ')))
        end as product_category_name,

        -- Metadatos de contenido (Casteo a entero para optimización)
        cast(product_name_lenght as integer) as product_name_length,
        cast(product_description_lenght as integer) as product_description_length,
        cast(product_photos_qty as integer) as product_photos_qty,

        -- Dimensiones físicas (Mantenemos precisión numérica)
        cast(product_weight_g as numeric(10,2)) as weight_g,
        cast(product_length_cm as numeric(10,2)) as length_cm,
        cast(product_height_cm as numeric(10,2)) as height_cm,
        cast(product_width_cm as numeric(10,2)) as width_cm

    from source
)

select * from transformed