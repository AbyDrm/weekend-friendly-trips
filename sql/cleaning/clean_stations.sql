CREATE OR REPLACE TABLE `weekend-friendly-trips-489113.cleaned.stations` AS

-- 1) CTE: remove duplicate stations based on IDRESEAU
WITH dedup AS(
  SELECT *,
  ROW_NUMBER() OVER(PARTITION BY IDRESEAU ORDER BY IDRESEAU) AS rn

  FROM `weekend-friendly-trips-489113.raw.raw_stations` 
)

-- 2) Final selection: keep only one row per IDRESEAU (rn = 1)
SELECT  

  -- Cleaned + renamed columns
  CAST(IDRESEAU AS STRING) AS station_id,
  CAST(CODE_UIC AS STRING) AS station_uic,
  LIBELLE AS station_name,
  VOYAGEURS = 'O' AS is_passenger_station, 
  COMMUNE AS city,
  DEPARTEMEN AS department, 
  X_WGS84 AS longitude, 
  Y_WGS84 AS latitude, 
  `Geo Point` AS geo_point,
  -- Distance from Paris (in kilometers)
  ST_DISTANCE(
    ST_GEOGPOINT(X_WGS84, Y_WGS84), -- station location
    ST_GEOGPOINT(2.355, 48.856) -- Paris city center
  )/ 1000 AS distance_from_paris_km

FROM dedup

WHERE rn = 1;