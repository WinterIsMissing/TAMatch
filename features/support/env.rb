require 'cucumber/rails'
# Capybara.default_selector = :css
OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
  :provider => 'google',
  :uid => '123545',
  :info => {
      :name => 'Sir Test',
      :email => 'sir_test@x.x'
  }
})