require "./models/snippet"

module Seed
  SNIPPETS = [
    {
      title:    "Quick sort in Python",
      language: "python",
      content:  <<-PY
def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left  = [x for x in arr if x < pivot]
    mid   = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + mid + quicksort(right)

print(quicksort([3, 6, 8, 10, 1, 2, 1]))
PY
    },
    {
      title:    "Fetch API with error handling",
      language: "javascript",
      content:  <<-JS
async function fetchUser(id) {
  try {
    const res = await fetch(`/api/users/${id}`);
    if (!res.ok) {
      throw new Error(`HTTP ${res.status}: ${res.statusText}`);
    }
    return await res.json();
  } catch (err) {
    console.error("Failed to fetch user:", err.message);
    return null;
  }
}

const user = await fetchUser(42);
console.log(user?.name ?? "unknown");
JS
    },
    {
      title:    "SQL window function for running totals",
      language: "sql",
      content:  <<-SQL
SELECT
  order_date,
  amount,
  SUM(amount) OVER (
    ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_total,
  ROUND(
    amount * 100.0 / SUM(amount) OVER (),
    2
  ) AS pct_of_total
FROM orders
WHERE customer_id = 7301
ORDER BY order_date;
SQL
    },
    {
      title:    "Ruby metaprogramming: dynamic methods",
      language: "ruby",
      content:  <<-RB
class ConfigStore
  def initialize(data = {})
    @data = data
  end

  def method_missing(name, *args)
    key = name.to_s
    if key.end_with?("=")
      @data[key.chomp("=")] = args.first
    else
      @data[key]
    end
  end

  def respond_to_missing?(name, include_private = false)
    true
  end
end

cfg = ConfigStore.new
cfg.host = "0.0.0.0"
cfg.port = 3000
puts cfg.host  # => "0.0.0.0"
RB
    },
    {
      title:    "Bash: safe directory cleanup",
      language: "bash",
      content:  <<-SH
#!/usr/bin/env bash
set -euo pipefail

cleanup_dir() {
  local dir="${1:-}"
  if [[ -z "$dir" ]]; then
    echo "Usage: cleanup_dir <path>" >&2
    return 1
  fi
  if [[ ! -d "$dir" ]]; then
    echo "Not a directory: $dir" >&2
    return 1
  fi
  # Remove files older than 7 days
  find "$dir" -type f -mtime +7 -print -delete
  echo "Cleaned $dir"
}

cleanup_dir "${1:-/tmp/cache}"
SH
    },
    {
      title:    "CSS grid responsive layout",
      language: "css",
      content:  <<-CSS
/* Responsive card grid with auto-fit */
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
  padding: 2rem;
}

.card {
  background: var(--surface-card);
  border: 1px solid var(--border-subtle);
  border-radius: 0; /* sharp corners */
  padding: 1.25rem;
  transition: box-shadow 150ms ease;
}

.card:hover {
  box-shadow: 0 2px 8px oklch(0.58 0.16 35 / 0.12);
}

@media (max-width: 640px) {
  .card-grid {
    grid-template-columns: 1fr;
    padding: 1rem;
  }
}
CSS
    },
    {
      title:    "Go: concurrent worker pool",
      language: "go",
      content:  <<-GO
package main

import (
  "fmt"
  "sync"
)

func worker(id int, jobs <-chan int, results chan<- int, wg *sync.WaitGroup) {
  defer wg.Done()
  for j := range jobs {
    fmt.Printf("worker %d processing job %d\n", id, j)
    results <- j * 2
  }
}

func main() {
  const numWorkers = 4
  const numJobs = 10

  jobs    := make(chan int, numJobs)
  results := make(chan int, numJobs)
  var wg  sync.WaitGroup

  for w := 1; w <= numWorkers; w++ {
    wg.Add(1)
    go worker(w, jobs, results, &wg)
  }

  for j := 1; j <= numJobs; j++ {
    jobs <- j
  }
  close(jobs)

  wg.Wait()
  close(results)

  for r := range results {
    fmt.Println("result:", r)
  }
}
GO
    },
    {
      title:    "TypeScript discriminated unions",
      language: "typescript",
      content:  <<-TS
type Shape =
  | { kind: "circle"; radius: number }
  | { kind: "rectangle"; width: number; height: number }
  | { kind: "triangle"; base: number; height: number };

function area(shape: Shape): number {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;
    case "rectangle":
      return shape.width * shape.height;
    case "triangle":
      return (shape.base * shape.height) / 2;
    default: {
      const _exhaustive: never = shape;
      return _exhaustive;
    }
  }
}

console.log(area({ kind: "circle", radius: 5 }));
TS
    },
    {
      title:    "Crystal HTTP server with Kemal",
      language: "crystal",
      content:  <<-CR
require "kemal"

Kemal.config.host_binding = "0.0.0.0"
Kemal.config.port = ENV.fetch("PORT", "3000").to_i

get "/" do
  "Hello from Crystal + Kemal!"
end

get "/api/health" do |env|
  env.response.content_type = "application/json"
  { "status" => "ok", "uptime" => Time.monotonic }.to_json
end

Kemal.run
CR
    },
    {
      title:    "Python regex for log parsing",
      language: "python",
      content:  <<-PY
import re
from datetime import datetime

LOG_PATTERN = re.compile(
    r'^(?P<timestamp>\S+ \S+) '
    r'\[(?P<level>\w+)\] '
    r'(?P<message>.+)$'
)

def parse_log_line(line: str) -> dict | None:
    m = LOG_PATTERN.match(line.strip())
    if not m:
        return None
    return {
        "time": datetime.strptime(
            m.group("timestamp"), "%Y-%m-%d %H:%M:%S"
        ),
        "level": m.group("level"),
        "message": m.group("message"),
    }

sample = "2025-01-15 14:32:10 [ERROR] Connection timeout"
print(parse_log_line(sample))
PY
    },
    {
      title:    "Docker multi-stage build for Go",
      language: "dockerfile",
      content:  <<-DF
# Stage 1 — build
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o /bin/server ./cmd/server

# Stage 2 — runtime
FROM scratch
COPY --from=builder /bin/server /server
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
EXPOSE 8080
ENTRYPOINT ["/server"]
DF
    },
    {
      title:    "Rust: iterator combinators",
      language: "rust",
      content:  <<-RS
fn top_three_by_score(scores: &[(String, u32)]) -> Vec<&(String, u32)> {
    let mut sorted: Vec<&(String, u32)> = scores.iter().collect();
    sorted.sort_by(|a, b| b.1.cmp(&a.1));
    sorted.into_iter().take(3).collect()
}

fn main() {
    let scores = vec![
        ("Alice".into(), 92),
        ("Bob".into(), 87),
        ("Carol".into(), 95),
        ("Dave".into(), 73),
        ("Eve".into(), 88),
    ];
    for (name, score) in top_three_by_score(&scores) {
        println!("{name}: {score}");
    }
}
RS
    },
  ]

  def self.run!
    db = Storage.open
    begin
      SNIPPETS.each do |s|
        db.exec(
          "INSERT INTO snippets (title, content, language) VALUES (?, ?, ?)",
          s[:title], s[:content].strip, s[:language]
        )
      end
      puts "Seeded #{SNIPPETS.size} demo snippets."
    ensure
      db.close
    end
  end
end
