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
  `Type équipement ou lieu` AS type,
  `Label et appellation` AS label,
  `Région` AS region,
  `Département` AS department,
  Domaine AS domain,
  Sous_domaine AS subdomain,
  CAST(Latitude AS FLOAT64) AS latitude,
  CAST(Longitude AS FLOAT64) AS longitude

FROM `weekend-friendly-trips-489113.raw.raw_cultural_places` 