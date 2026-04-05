# frozen_string_literal: true

namespace :ridgepole do
  desc "Apply Schemafile to database"
  task apply: :environment do
    sh "bundle exec ridgepole --config config/database.yml --env #{Rails.env} --file db/Schemafile --apply"
  end

  desc "Dry run (show pending changes)"
  task dry_run: :environment do
    sh "bundle exec ridgepole --config config/database.yml --env #{Rails.env} --file db/Schemafile --apply --dry-run"
  end

  desc "Export current schema to db/Schemafile.exported"
  task export: :environment do
    sh "bundle exec ridgepole --config config/database.yml --env #{Rails.env} --output db/Schemafile.exported --export"
  end
end
