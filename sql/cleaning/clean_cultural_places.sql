CREATE OR REPLACE TABLE `weekend-friendly-trips-489113.cleaned.cultural_places`AS 
SELECT
  -- Surrogate key
  TO_HEX(SHA256(
    CONCAT(
      COALESCE(Nom,''),
      COALESCE(Adresse,''),
      COALESCE(CAST(`Code Postal` AS STRING),''),
      COALESCE(CAST(`Latitude` AS STRING),''),
      COALESCE(CAST(`Longitude` AS STRING),'')
    )
  )) AS place_id,

  -- Cleaned + renamed columns
  Nom AS name,
  Adresse AS address,
  CAST(`Code Postal` AS STRING) AS postcode,
  libelle_geographique AS city,
  code_insee AS city_insee_code,
  `Type équipement ou lieu` AS type,
  `Label et appellation` AS label,
  `Région` AS region,
  `Département` AS department,
  Domaine AS domain,
  Sous_domaine AS subdomain,
  CAST(Latitude AS FLOAT64) AS latitude,
  CAST(Longitude AS FLOAT64) AS longitude,
  
  -- Distance from Paris (in kilometers)
  ST_DISTANCE(
    ST_GEOGPOINT(longitude, latitude), -- place distance
    ST_GEOGPOINT(2.355, 48.856) -- Paris city center
  ) / 1000 AS distance_from_paris_km

FROM `weekend-friendly-trips-489113.raw.raw_cultural_places` 