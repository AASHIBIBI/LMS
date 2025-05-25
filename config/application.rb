require_relative 'boot'

# Remove the line requiring rails/all and only include what we need
require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_record/railtie" # Commented out to skip database
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"
# require "active_storage/engine" # Commented out to skip ActiveStorage

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LibraryManagementSystem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Skip database initialization
    config.paths['config/database'] = '/dev/null'
    
    # Set up global configuration for mock data mode
    config.mock_data = true
    
    # Disable generation of migration, model, fixture, and factory files
    config.generators do |g|
      g.orm :active_record, false
    end
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    # Prevent middleware modification error by handling it during initialization
    config.to_prepare do
      # This is safer than removing middleware directly
      # Let the mock classes handle the database-related functionality
    end
  end
end
