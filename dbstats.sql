.headers on
.mode table
SELECT
    'notifications' AS table_name,
    (SELECT COUNT(*) FROM notifications) AS row_count,
    (SELECT SUM(pgsize) FROM dbstat WHERE name = 'notifications') AS size_bytes,
    ROUND((SELECT SUM(pgsize) FROM dbstat WHERE name = 'notifications') / 1024.0, 2) AS size_kb,
    ROUND(
      1.0 * (SELECT SUM(pgsize) FROM dbstat WHERE name = 'notifications') /
      NULLIF((SELECT COUNT(*) FROM notifications), 0), 2
    ) AS bytes_per_row

  UNION ALL

SELECT
  'follower',
  (SELECT COUNT(*) FROM follower),
  (SELECT SUM(pgsize) FROM dbstat WHERE name = 'follower'),
  ROUND((SELECT SUM(pgsize) FROM dbstat WHERE name = 'follower') / 1024.0, 2),
  ROUND(
    1.0 * (SELECT SUM(pgsize) FROM dbstat WHERE name = 'follower') /
    NULLIF((SELECT COUNT(*) FROM follower), 0), 2
  )

UNION ALL

SELECT
  'following',
  (SELECT COUNT(*) FROM following),
  (SELECT SUM(pgsize) FROM dbstat WHERE name = 'following'),
  ROUND((SELECT SUM(pgsize) FROM dbstat WHERE name = 'following') / 1024.0, 2),
  ROUND(
    1.0 * (SELECT SUM(pgsize) FROM dbstat WHERE name = 'following') /
    NULLIF((SELECT COUNT(*) FROM following), 0), 2
  )

UNION ALL

SELECT
  'toots_home',
  (SELECT COUNT(*) FROM toots_home),
  (SELECT SUM(pgsize) FROM dbstat WHERE name = 'toots_home'),
  ROUND((SELECT SUM(pgsize) FROM dbstat WHERE name = 'toots_home') / 1024.0, 2),
  ROUND(
    1.0 * (SELECT SUM(pgsize) FROM dbstat WHERE name = 'toots_home') /
    NULLIF((SELECT COUNT(*) FROM toots_home), 0), 2
  );
