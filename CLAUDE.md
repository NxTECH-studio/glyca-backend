# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Glyca Backend — Rails 8.1 API-only application (Ruby 4.0.2, PostgreSQL).

## Common Commands

```bash
# Server
bin/rails server

# Tests
bundle exec rspec                        # Run all tests
bundle exec rspec spec/models/           # Run tests in a directory
bundle exec rspec spec/models/user_spec.rb       # Run a single file
bundle exec rspec spec/models/user_spec.rb:42    # Run a single example by line

# Linting
bundle exec rubocop                      # Run all checks
bundle exec rubocop -a                   # Auto-correct safe cops
bundle exec rubocop -A                   # Auto-correct all (including unsafe)

# Security
bin/brakeman --no-pager                  # Static analysis
bin/bundler-audit                        # Gem vulnerability scan

# Database
bin/rails db:create
bundle exec ridgepole -c config/database.yml -E development --apply -f db/Schemafile  # Apply schema
bundle exec ridgepole -c config/database.yml -E test --apply -f db/Schemafile         # Apply schema (test)
```

## Architecture

- **API-only**: No views/assets. `config.api_only = true`.
- **Schema management**: Uses [Ridgepole](https://github.com/ridgepole/ridgepole) instead of Rails migrations. Define tables in `db/Schemafile` (or require sub-files from it).
- **Background jobs**: Solid Queue (database-backed Active Job adapter).
- **Caching**: Solid Cache (database-backed Rails.cache adapter).
- **Deployment**: Kamal (Docker-based). See `config/deploy.yml` and `Dockerfile`.
- **DB connection**: Configured via `DB_HOST`, `DB_USERNAME`, `DB_PASSWORD` env vars.

## Code Style (RuboCop)

Key non-default rules — follow these when writing code:

- **Strings**: Double quotes (`"hello"`, not `'hello'`). Exception: Gemfile.
- **Hash shorthand**: Disabled — always use explicit `key: value`, never `key:` shorthand (`Style/HashSyntax: never`).
- **Trailing commas**: Required in multiline arguments, arrays, and hashes.
- **Module style**: Compact (`class Foo::Bar`, not nested modules).
- **Line length**: 160 max (no limit in specs).
- **Lambda style**: Literal (`-> { }`, not `lambda { }`).
- **`let` vs `let!` in RSpec**: Custom cop `RSpec/PreferLetBang` is enabled — prefer `let!`.
- **Documentation**: Required on models, jobs, and services (except base classes).
- **Predicate prefix**: `is_` is forbidden (use `active?` not `is_active?`).

## Testing

- RSpec with FactoryBot (use `create`, `build` etc. directly — syntax methods included).
- `database_rewinder` for DB cleanup.
- `bullet` for N+1 detection.
- `test-prof` for profiling.
- SimpleCov enabled in CI (`CI=true` or `COVERAGE=true`).
- `TimeHelpers` included — use `travel_to`, `freeze_time` etc.
