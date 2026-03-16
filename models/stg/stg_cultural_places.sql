with source as (
    select 
        {{ dbt_utils.generate_surrogate_key([
            'Nom',
            'Adresse',
            '`Code Postal`',
            'libelle_geographique',
            'Latitude',
            'Longitude'
        ])}} as place_id
        Nom as name,
        Adresse as address,
        cast(`Code Postal` as string) as postcode,
        libelle_geographique as city,
        `Type équipement ou lieu` as place_type,
        `Label et appellation` as label,
        Région as region,
        Département as department,
        Domaine as domain,
        Sous_domaine as subdomain,
        Latitude as latitude,
        Longitude as longitude,
        coordonnees_geo as geo_coordinates, 
    from {{source('raw', 'raw_cultural_places') }}
)

select *
from source
where latitude is not null and longitude is not null 
 