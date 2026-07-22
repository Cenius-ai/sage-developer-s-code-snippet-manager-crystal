require "db"

struct Snippet
  getter id : Int64
  getter title : String
  getter content : String
  getter language : String
  getter created_at : String

  def initialize(@id, @title, @content, @language, @created_at)
  end

  def self.from_rs(rs : DB::ResultSet) : Snippet
    Snippet.new(
      id: rs.read(Int64),
      title: rs.read(String),
      content: rs.read(String),
      language: rs.read(String),
      created_at: rs.read(String)
    )
  end

  def self.recent(limit : Int32 = 12, db : DB::Database? = nil) : Array(Snippet)
    conn = db || Storage.open
    begin
      results = [] of Snippet
      conn.query("SELECT id, title, content, language, created_at FROM snippets ORDER BY created_at DESC LIMIT ?", limit) do |rs|
        rs.each do
          results << from_rs(rs)
        end
      end
      results
    ensure
      conn.close unless db
    end
  end

  def self.find(id : Int64, db : DB::Database? = nil) : Snippet?
    conn = db || Storage.open
    begin
      conn.query_one?("SELECT id, title, content, language, created_at FROM snippets WHERE id = ?", id) do |rs|
        from_rs(rs)
      end
    ensure
      conn.close unless db
    end
  end

  def self.search_by_language(language : String, db : DB::Database? = nil) : Array(Snippet)
    conn = db || Storage.open
    begin
      results = [] of Snippet
      conn.query(
        "SELECT id, title, content, language, created_at FROM snippets WHERE LOWER(language) = LOWER(?) ORDER BY created_at DESC",
        language
      ) do |rs|
        rs.each do
          results << from_rs(rs)
        end
      end
      results
    ensure
      conn.close unless db
    end
  end

  def self.create(title : String, content : String, language : String, db : DB::Database? = nil) : Snippet
    conn = db || Storage.open
    begin
      conn.exec(
        "INSERT INTO snippets (title, content, language) VALUES (?, ?, ?)",
        title, content, language
      )
      id = conn.scalar("SELECT last_insert_rowid()").as(Int64)
      find(id, conn).not_nil!
    ensure
      conn.close unless db
    end
  end

  def self.languages(db : DB::Database? = nil) : Array(String)
    conn = db || Storage.open
    begin
      results = [] of String
      conn.query("SELECT DISTINCT language FROM snippets ORDER BY language") do |rs|
        rs.each do
          results << rs.read(String)
        end
      end
      results
    ensure
      conn.close unless db
    end
  end
end
