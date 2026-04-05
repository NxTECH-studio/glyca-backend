require "test_prof/recipes/rspec/let_it_be"

TestProf::LetItBe.configure do |config|
  config.default_modifiers[:refind] = true
end
