DROP MATERIALIZED VIEW IF EXISTS mos_archive_status;
CREATE MATERIALIZED VIEW
  mos_archive_status
AS
WITH dates AS (
SELECT 
  t.day 
FROM 
  generate_series(timestamp '2011-12-01', current_date::timestamp - interval '12 hours', interval '12 hours') AS t(day)
)
SELECT
  extract(epoch FROM d.day) AS origintime,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 1373 THEN 1 ELSE 0 END)::smallint AS BLDIS_JM2,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 1374 THEN 1 ELSE 0 END)::smallint AS CEIL_M,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 276 THEN 1 ELSE 0 END)::smallint AS CLDBASE_M,
  SUM(CASE WHEN e.level_id = 2 AND e.param_id = 1031 THEN 1 ELSE 0 END)::smallint AS FF_MEAN_MS_PRESSURE,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 1028 THEN 1 ELSE 0 END)::smallint AS FFG_MEAN_MS,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 411 THEN 1 ELSE 0 END)::smallint AS FFG_MS,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 88 THEN 1 ELSE 0 END)::smallint AS FLLAT_JM2,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 89 THEN 1 ELSE 0 END)::smallint AS FLSEN_JM2,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 1371 THEN 1 ELSE 0 END)::smallint AS IEWSS_NM2S,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 703 THEN 1 ELSE 0 END)::smallint AS IFFG_MS,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 1372 THEN 1 ELSE 0 END)::smallint AS INSSS_NM2S,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 655 THEN 1 ELSE 0 END)::smallint AS MIXHGT_M,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 974 THEN 1 ELSE 0 END)::smallint AS NH_0TO1,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 972 THEN 1 ELSE 0 END)::smallint AS NL_0TO1,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 973 THEN 1 ELSE 0 END)::smallint AS NM_0TO1,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 981 THEN 1 ELSE 0 END)::smallint AS P_MEAN_PA,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 139 THEN 1 ELSE 0 END)::smallint AS P_PA,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 2 THEN 1 ELSE 0 END)::smallint AS PRECFORM_N,
  SUM(CASE WHEN e.level_id = 3 AND e.param_id = 138 THEN 1 ELSE 0 END)::smallint AS Q_KGKG_HYBRID,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 316 THEN 1 ELSE 0 END)::smallint AS RNETLWA_JM2,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 1393 THEN 1 ELSE 0 END)::smallint AS RNETSWA_MEAN_JM2,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 314 THEN 1 ELSE 0 END)::smallint AS RNETSWA_JM2,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 179 THEN 1 ELSE 0 END)::smallint AS RR_KGM2,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 1357 THEN 1 ELSE 0 END)::smallint AS SD_TM2,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 218 THEN 1 ELSE 0 END)::smallint AS SKT_K,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 702 THEN 1 ELSE 0 END)::smallint AS TCW_KGM2,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 1395 THEN 1 ELSE 0 END)::smallint AS TD_MEAN_K,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 162 THEN 1 ELSE 0 END)::smallint AS TD_K,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 980 THEN 1 ELSE 0 END)::smallint AS T_MEAN_K,
  SUM(CASE WHEN e.level_id = 2 AND e.param_id = 980 THEN 1 ELSE 0 END)::smallint AS T_MEAN_K_PRESSURE,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 153 THEN 1 ELSE 0 END)::smallint AS T_K,
  SUM(CASE WHEN e.level_id = 3 AND e.param_id = 153 THEN 1 ELSE 0 END)::smallint AS T_K_HYBRID,
  SUM(CASE WHEN e.level_id = 2 AND e.param_id = 153 THEN 1 ELSE 0 END)::smallint AS T_K_PRESSURE,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 982 THEN 1 ELSE 0 END)::smallint AS T_STDDEV_K,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 214 THEN 1 ELSE 0 END)::smallint AS TMAX_K,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 215 THEN 1 ELSE 0 END)::smallint AS TMIN_K,
  SUM(CASE WHEN e.level_id = 2 AND e.param_id = 171 THEN 1 ELSE 0 END)::smallint AS U_MEAN_MS_PRESSURE,
  SUM(CASE WHEN e.level_id = 2 AND e.param_id = 174 THEN 1 ELSE 0 END)::smallint AS V_MEAN_MS_PRESSURE,
  SUM(CASE WHEN e.level_id = 1 AND e.level_value = 0 AND e.param_id = 171 THEN 1 ELSE 0 END)::smallint AS U_MS,
  SUM(CASE WHEN e.level_id = 1 AND e.level_value = 0 AND e.param_id = 174 THEN 1 ELSE 0 END)::smallint AS V_MS,
  SUM(CASE WHEN e.level_id = 1 AND e.level_value = 100 AND e.param_id = 171 THEN 1 ELSE 0 END)::smallint AS U_MS_100M,
  SUM(CASE WHEN e.level_id = 1 AND e.level_value = 100 AND e.param_id = 174 THEN 1 ELSE 0 END)::smallint AS V_MS_100M,
  SUM(CASE WHEN e.level_id = 1 AND e.param_id = 426 THEN 1 ELSE 0 END)::smallint AS VV_M,
  SUM(CASE WHEN e.level_id = 2 AND e.param_id = 158 THEN 1 ELSE 0 END)::smallint AS Z_M2S2_PRESSURE
FROM
  dates d LEFT OUTER JOIN data.grid_ecg e
ON (d.day = e.analysis_time)
GROUP BY d.day
ORDER BY d.day::date DESC, d.day::time ASC;

GRANT SELECT ON mos_archive_status TO radon_ro;
