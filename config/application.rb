require_relative 'boot'

require 'rails/all'

require 'open-uri'
require 'net/http'
require 'uri'
require 'json'
require 'jwt'
require 'oauth2'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CarGapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :options]
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
