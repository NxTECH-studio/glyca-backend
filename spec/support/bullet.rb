RSpec.configure do |config|
  config.around(:each, type: :request) do |example|
    Bullet.enable = false
    example.run
    Bullet.enable = true
  end
end
