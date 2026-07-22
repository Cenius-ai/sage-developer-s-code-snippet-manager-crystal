require "sqlite3"
require "db"
require "file_utils"

module Storage
  DB_PATH = File.join(__DIR__, "..", "data", "sage.db")

  def self.open : DB::Database
    Dir.mkdir_p(File.dirname(DB_PATH))
    db = DB.open("sqlite3://#{DB_PATH}")
    db.exec "PRAGMA journal_mode = WAL"
    db.exec "PRAGMA busy_timeout = 5000"
    db.exec "PRAGMA foreign_keys = ON"
    db
  end

  def self.setup!
    db = open
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS snippets (
        id         INTEGER PRIMARY KEY AUTOINCREMENT,
        title      TEXT    NOT NULL,
        content    TEXT    NOT NULL,
        language   TEXT    NOT NULL DEFAULT 'text',
        created_at TEXT    NOT NULL DEFAULT (datetime('now'))
      )
    SQL
    count = db.scalar("SELECT count(*) FROM snippets").as(Int64)
    if count == 0
      db.close
      Seed.run!
    else
      db.close
    end
  end
end

require "./seed"
