MODEL (
  name sqlmesh_example.latest_session,
  kind VIEW
);

SELECT DISTINCT
    event_date,
    user_pseudo_id, 
    FIRST_VALUE(@get_param_value(ep, 'ga_session_id')) 
      OVER (UserWindow) AS ga_session_id,
    FIRST_VALUE(@get_param_value(ep, 'ga_session_number'))
      OVER (UserWindow) AS ga_session_number
FROM sqlmesh_example.gcs_load, UNNEST(event_params) as ep(key)
WHERE
  user_pseudo_id IN @get_user_list()
WINDOW UserWindow AS (PARTITION BY user_pseudo_id ORDER BY event_timestamp DESC);

@IF(
  @runtime_stage = 'creating',
  COPY sqlmesh_example.latest_session TO @get_output_uri()
);