MODEL (
  name sqlmesh_example.gcs_load,
  kind VIEW
);

SELECT 
  *
FROM read_parquet(@get_date_range_list());
