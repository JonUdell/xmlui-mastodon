-- Drop existing FTS tables to remove duplicates
DROP TABLE IF EXISTS toots_fts;
DROP TABLE IF EXISTS notifications_fts;
DROP TABLE IF EXISTS quick_search_fts;

-- Recreate FTS4 virtual table for toots
CREATE VIRTUAL TABLE toots_fts USING fts4(
  id,
  author_name,
  reblog_author_name,
  content,
  reblog_content,
  created_at,
  reblog_created_at,
  url
);

-- Recreate FTS4 virtual table for notifications
CREATE VIRTUAL TABLE notifications_fts USING fts4(
  id,
  display_name,
  status_content,
  note,
  category,
  created_at,
  status_url,
  account_url
);

-- Recreate fast gating search index
CREATE VIRTUAL TABLE quick_search_fts USING fts4(
  id,
  source_type,
  all_text
);

-- Populate toots_fts from existing data (clean, no duplicates)
INSERT INTO toots_fts(
  id, author_name, reblog_author_name, content, reblog_content,
  created_at, reblog_created_at, url
)
SELECT
  id, author_name, reblog_author_name, content, reblog_content,
  created_at, reblog_created_at, url
FROM toots_home;

-- Populate notifications_fts from existing data (clean, no duplicates)
INSERT INTO notifications_fts(
  id, display_name, status_content, note, category,
  created_at, status_url, account_url
)
SELECT
  id, display_name, status_content, note, category,
  created_at, status_url, account_url
FROM notifications;

-- Populate quick search index with all text combined (clean, no duplicates)
INSERT INTO quick_search_fts(id, source_type, all_text)
SELECT
  id,
  'toot',
  COALESCE(author_name, '') || ' ' ||
  COALESCE(reblog_author_name, '') || ' ' ||
  COALESCE(content, '') || ' ' ||
  COALESCE(reblog_content, '')
FROM toots_home

UNION ALL

SELECT
  id,
  'notification',
  COALESCE(display_name, '') || ' ' ||
  COALESCE(status_content, '') || ' ' ||
  COALESCE(note, '') || ' ' ||
  COALESCE(category, '')
FROM notifications;