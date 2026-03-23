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
   site_internet AS website,
   adresse_email AS email,
   annee_de_creation_d_festival AS creation_year,
   discipline_dominante AS category,
   periode_principale_de_deroulement_du_festival AS period,
   geocodage_xy AS geo_coordinates

FROM `weekend-friendly-trips-489113.raw.raw_festivals` 