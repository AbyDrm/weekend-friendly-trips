with source as (
    select
        {{ dbt_utils.generate_surrogate_key([
            'nom_du_festival', 
            'code_postal', 
            'commune_principale_de_deroulement'
        ])}} as festival_id,
        nom_du_festival as name,
        region_principale_de_deroulement as region,
        departement_principal_de_deroulement as department,
        commune_principale_de_deroulement as city,
        cast(code_postal as string) as postcode, 
        site_internet as website, 
        adresse_email as email,
        cast (annee_de_creation_du_festival as int64) as creation_year, 
        discipline_dominante as category,
        periode_principale_de_deroulement_du_festival as period, 
        geocodage_xy as geo_coordinates
    from {{ source ('raw', 'raw_festivals')}}
)

select *
from source 