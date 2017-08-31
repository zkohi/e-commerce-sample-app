require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ECommerceSampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.generators do |g|
      g.orm :active_record
      g.assets false
      g.helper false
      g.test_framework :rspec,
        fixture: true,
        fixture_replacement: :factory_girl,
        view_specs: false,
        routing_specs: false,
        helper_specs: false,
        integration_tool: :rspec
      g.system_tests false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Tokyo'
  end
end
