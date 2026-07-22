require "kemal"
require "./db"
require "./models/snippet"
require "./view_context"

Kemal.config.host_binding = "0.0.0.0"
Kemal.config.port = ENV.fetch("PORT", "3000").to_i

serve_static({"gzip" => true, "dir_listing" => false})

# ── Static asset headers ──────────────────────────────────────────
static_headers do |env, path, filestat|
  if path.ends_with?(".woff2")
    env.response.headers["Cache-Control"] = "public, max-age=604800, immutable"
  end
end

# ── Database setup (auto-create schema + seed on first boot) ───────
Storage.setup!

# ── GET / — Homepage with recent snippets ──────────────────────────
get "/" do |env|
  View.reset!
  View.page_title = "Sage — Snippets"
  View.snippets = Snippet.recent
  render "views/index.ecr"
end

# ── GET /snippet/:id — View a single snippet ───────────────────────
get "/snippet/:id" do |env|
  View.reset!
  id = env.params.url["id"].to_i64 rescue 0_i64
  snip = Snippet.find(id)
  if snip
    View.page_title = "#{snip.title} — Sage"
    View.snippet = snip
    render "views/show.ecr"
  else
    env.response.status_code = 404
    View.page_title = "Not Found — Sage"
    View.error_msg = "Snippet not found."
    render "views/new.ecr"
  end
end

# ── GET /new — Snippet creation form ───────────────────────────────
get "/new" do |env|
  View.reset!
  View.page_title = "New Snippet — Sage"
  render "views/new.ecr"
end

# ── POST /create — Handle snippet submission ───────────────────────
post "/create" do |env|
  View.reset!
  title    = env.params.body["title"]?.try(&.strip)
  language = env.params.body["language"]?.try(&.strip)
  content  = env.params.body["content"]?.try(&.strip)

  if title.nil? || title.empty? || content.nil? || content.empty? || language.nil? || language.empty?
    View.page_title = "New Snippet — Sage"
    View.error_msg = "All fields are required."
    View.form_title = title
    View.form_language = language
    View.form_content = content
    env.response.status_code = 422
    render "views/new.ecr"
  else
    snippet = Snippet.create(title: title, content: content, language: language)
    env.redirect "/snippet/#{snippet.id}"
  end
end

# ── GET /search — Filter snippets by language ──────────────────────
get "/search" do |env|
  View.reset!
  lang = env.params.query["lang"]?.try(&.strip)
  View.page_title = "Search — Sage"
  View.query = lang

  if lang && !lang.empty?
    View.snippets = Snippet.search_by_language(lang)
  else
    View.snippets = Snippet.recent
  end

  render "views/search.ecr"
end

# ── GET /about — About page ────────────────────────────────────────
get "/about" do |env|
  View.reset!
  View.page_title = "About — Sage"
  render "views/about.ecr"
end

# ── GET /health — Health check ─────────────────────────────────────
get "/health" do |env|
  env.response.content_type = "application/json"
  { "status" => "ok" }.to_json
end

# ── 404 handler ────────────────────────────────────────────────────
error 404 do |env|
  View.reset!
  View.page_title = "Not Found — Sage"
  View.error_msg = "The page you are looking for does not exist."
  View.snippets = Snippet.recent
  render "views/index.ecr"
end

# ── 500 handler ────────────────────────────────────────────────────
error 500 do |env, err|
  View.reset!
  View.page_title = "Error — Sage"
  View.error_msg = "Something went wrong. Please try again."
  View.snippets = Snippet.recent
  env.response.status_code = 500
  render "views/index.ecr"
end

puts "Sage listening on 0.0.0.0:#{Kemal.config.port}"
Kemal.run
