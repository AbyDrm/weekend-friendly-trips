CREATE OR REPLACE TABLE `weekend-friendly-trips-489113.cleaned.train_fares` AS

SELECT 
  -- Surrogate key
  TO_HEX(SHA256(
    CONCAT(
      COALESCE(Transporteur, ''),
      COALESCE(CAST(`Gare origine - code UIC` AS STRING), ''),
      COALESCE(CAST(`Gare destination - code UIC` AS STRING), ''),
      COALESCE(CAST(Classe AS STRING), ''),
      COALESCE(`Profil tarifaire`, '')
    )
  )
  ) AS fare_id,

  -- Cleaned + renamed columns
  Transporteur AS operator,
  `Gare origine` AS origin_station, 
  CAST(`Gare origine - code UIC` AS STRING) AS origin_uic,
  `Gare destination` AS destination_station, 
  CAST(`Gare destination - code UIC` AS STRING) AS destination_uic,
  Classe AS class,
  `Profil tarifaire` AS fare_type,
  `Prix minimum`AS min_price,
  `Prix maximum`AS max_price

FROM `weekend-friendly-trips-489113.raw.raw_train_fares` 