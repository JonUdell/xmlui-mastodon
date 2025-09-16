CREATE TABLE follower(
  account_id TEXT,
  account TEXT,
  id TEXT,
  acct TEXT,
  created_at TEXT,
  url TEXT,
  instance_qualified_account_url TEXT,
  username TEXT,
  server TEXT,
  display_name TEXT,
  followers_count INT,
  following_count INT,
  statuses_count INT,
  note TEXT,
  sp_connection_name TEXT,
  sp_ctx TEXT,
  _ctx TEXT
);
CREATE TABLE IF NOT EXISTS "following"(
  account_id TEXT,
  account TEXT,
  id TEXT,
  acct TEXT,
  created_at TEXT,
  url TEXT,
  instance_qualified_account_url TEXT,
  username TEXT,
  server TEXT,
  display_name TEXT,
  followers_count INT,
  following_count INT,
  statuses_count INT,
  note TEXT,
  sp_connection_name TEXT,
  sp_ctx TEXT,
  _ctx TEXT
);
CREATE TABLE notifications (
        id text primary key,
        category text,
        created_at text,
        account text,
        display_name text,
        account_url text,
        instance_qualified_account_url text,
        account_id text,
        status text,
        status_url text,
        instance_qualified_status_url text,
        status_content text,
        sp_connection_name text,
        sp_ctx text,
        _ctx text,

        -- Additional fields for UI display
        avatar_url text,
        header_url text,
        note text,
        followers_count integer,
        following_count integer,
        statuses_count integer,
        in_reply_to_id text,
        in_reply_to_account_id text,
        preview_url text,
        username text
      );
CREATE INDEX idx_follower_id on follower(id);
CREATE TABLE toots_home (
        id TEXT PRIMARY KEY,
        author_name TEXT,
        reblog_author_name TEXT,
        created_at TEXT,
        reblog_created_at TEXT,
        content TEXT,
        reblog_content TEXT,
        url TEXT
      , in_reply_to_id text, in_reply_to_account_id text, account_id text, replies_count integer);
CREATE VIRTUAL TABLE fts4_test USING fts4(content)
/* fts4_test(content) */;
CREATE VIRTUAL TABLE toots_fts USING fts4(
            id,
            author_name,
            reblog_author_name,
            content,
            reblog_content,
            created_at,
            reblog_created_at,
            url
          )
/* toots_fts(id,author_name,reblog_author_name,content,reblog_content,created_at,reblog_created_at,url) */;
CREATE TABLE IF NOT EXISTS 'toots_fts_content'(docid INTEGER PRIMARY KEY, 'c0id', 'c1author_name', 'c2reblog_author_name', 'c3content', 'c4reblog_content', 'c5created_at', 'c6reblog_created_at', 'c7url');
CREATE TABLE IF NOT EXISTS 'toots_fts_segments'(blockid INTEGER PRIMARY KEY, block BLOB);
CREATE TABLE IF NOT EXISTS 'toots_fts_segdir'(level INTEGER,idx INTEGER,start_block INTEGER,leaves_end_block INTEGER,end_block INTEGER,root BLOB,PRIMARY KEY(level, idx));
CREATE TABLE IF NOT EXISTS 'toots_fts_docsize'(docid INTEGER PRIMARY KEY, size BLOB);
CREATE TABLE IF NOT EXISTS 'toots_fts_stat'(id INTEGER PRIMARY KEY, value BLOB);
CREATE VIRTUAL TABLE notifications_fts USING fts4(
            id,
            display_name,
            status_content,
            note,
            category,
            created_at,
            status_url,
            account_url
          )
/* notifications_fts(id,display_name,status_content,note,category,created_at,status_url,account_url) */;
CREATE TABLE IF NOT EXISTS 'notifications_fts_content'(docid INTEGER PRIMARY KEY, 'c0id', 'c1display_name', 'c2status_content', 'c3note', 'c4category', 'c5created_at', 'c6status_url', 'c7account_url');
CREATE TABLE IF NOT EXISTS 'notifications_fts_segments'(blockid INTEGER PRIMARY KEY, block BLOB);
CREATE TABLE IF NOT EXISTS 'notifications_fts_segdir'(level INTEGER,idx INTEGER,start_block INTEGER,leaves_end_block INTEGER,end_block INTEGER,root BLOB,PRIMARY KEY(level, idx));
CREATE TABLE IF NOT EXISTS 'notifications_fts_docsize'(docid INTEGER PRIMARY KEY, size BLOB);
CREATE TABLE IF NOT EXISTS 'notifications_fts_stat'(id INTEGER PRIMARY KEY, value BLOB);
