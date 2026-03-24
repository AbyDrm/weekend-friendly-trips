CREATE OR REPLACE TABLE `weekend-friendly-trips-489113.cleaned.festivals` AS
SELECT  
   -- Surrogate key
   TO_HEX(SHA256(
    CONCAT(
      COALESCE(nom_du_festival, ''),
      COALESCE(commune_principale_de_deroulement, ''),
      COALESCE(code_postal, '')
    ) 
   )) AS festival_id,

   -- Cleaned + renamed columns
   nom_du_festival AS name,
   region_principale_de_deroulement AS region,
   departement_principal_de_deroulement AS department,
   commune_principale_de_deroulement AS city,
   CAST(code_postal AS string) as postcode,
   code_insee_commune AS city_insee_code, 
   site_internet AS website,
   adresse_email AS email,
   annee_de_creation_d_festival AS creation_year,
   discipline_dominante AS category,
   periode_principale_de_deroulement_du_festival AS period,
   geocodage_xy AS geo_point,

   -- Extract longitude and latitude from geocodage_xy
   CAST(SPLIT(geocodage_xy, ",")[OFFSET(0)] AS FLOAT64) AS latitude,
   CAST(SPLIT(geocodage_xy, ",")[OFFSET(1)] AS FLOAT64) AS longitude,

   -- Distance from Paris (in kilometers)
   ST_DISTANCE(
    ST_GEOGPOINT(
      CAST(SPLIT(geocodage_xy, ",")[OFFSET(1)] AS FLOAT64), -- longitude
      CAST(SPLIT(geocodage_xy, ",")[OFFSET(0)] AS FLOAT64)  -- latitude
    ), -- festival location
    ST_GEOGPOINT(2.355, 48.856) -- Paris city center
   ) / 1000 AS distance_from_paris_km


FROM `weekend-friendly-trips-489113.raw.raw_festivals` 