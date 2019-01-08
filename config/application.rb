require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Passwordless
  class Application < Rails::Application
    # config.web_console.whitelisted_ips = '202.94.70.52'
    # config.web_console.whitelisted_ips = '103.24.77.52'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
