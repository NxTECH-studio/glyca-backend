require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

if ENV["CI"] || ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start "rails" do
    enable_coverage :branch
  end
end

Rails.root.glob("spec/support/**/*.rb").sort_by(&:to_s).each { |f| require f }

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseRewinder.clean_all
  end
end
