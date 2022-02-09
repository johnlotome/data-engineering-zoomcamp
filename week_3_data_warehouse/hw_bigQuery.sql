CREATE OR REPLACE EXTERNAL TABLE `dtc-dte-coursework.nyc_taxi_rides.external_yellow_tripdata`
OPTIONS (
  format = 'CSV',
  uris = ['gs://nyc-tlc-data2/trip data/yellow_tripdata_2019-*.csv', 'gs://nyc-tlc-data2/trip data/yellow_tripdata_2020-*.csv']
);

SELECT * FROM dtc-dte-coursework.nyc_taxi_rides.external_yellow_tripdata LIMIT 100; 

-- fhv tripdata
CREATE OR REPLACE EXTERNAL TABLE `dtc-dte-coursework.nyc_taxi_rides.external_fhv_tripdata2019`
OPTIONS (
  format = 'CSV',
  uris = ['gs://nyc-tlc-data2/trip data/fhv_tripdata_2019-*.csv']
);

-- Question1
SELECT COUNT(*) FROM dtc-dte-coursework.nyc_taxi_rides.external_fhv_tripdata2019;

-- Question2
SELECT * FROM `dtc-dte-coursework.nyc_taxi_rides.external_fhv_tripdata2019` LIMIT 100;

SELECT DISTINCT dispatching_base_num, COUNT(*) AS counter FROM `dtc-dte-coursework.nyc_taxi_rides.external_fhv_tripdata2019`
GROUP BY dispatching_base_num;

SELECT COUNT(DISTINCT dispatching_base_num) FROM `dtc-dte-coursework.nyc_taxi_rides.external_fhv_tripdata2019`;

-- Question3
-- Question4
CREATE OR REPLACE EXTERNAL TABLE `dtc-dte-coursework.nyc_taxi_rides.external_fhv_tripdata201901-03`
OPTIONS (
  format = 'CSV',
  uris = ['gs://nyc-tlc-data2/trip data/fhv_tripdata_2019-01.csv', 'gs://nyc-tlc-data2/trip data/fhv_tripdata_2019-02.csv',
  'gs://nyc-tlc-data2/trip data/fhv_tripdata_2019-03.csv']
);

SELECT COUNT(*) FROM `dtc-dte-coursework.nyc_taxi_rides.external_fhv_tripdata2019` 
WHERE pickup_datetime between DATE("2019-01-01") and DATE("2019-03-31")
AND dispatching_base_num IN ('B00987', 'B02060', 'B02279');

SELECT COUNT(*) FROM `dtc-dte-coursework.nyc_taxi_rides.external_fhv_tripdata201901-03` 
WHERE dispatching_base_num IN ('B00987', 'B02060', 'B02279');









