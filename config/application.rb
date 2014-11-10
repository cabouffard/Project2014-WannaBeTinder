require File.expand_path('../csrf_protection', __FILE__)

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Projet
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be eager loaded.
    # Change back to autoload_paths in Rails 4.0
    config.eager_load_paths += Dir["#{config.root}/lib/**/"]
    config.eager_load_paths += Dir["#{config.root}/app/**/concerns/"]
    config.autoload_paths += config.eager_load_paths

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = "Eastern Time (US & Canada)"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join("my", "locales", "*.{rb,yml}").to_s]
    # config.i18n.default_locale = :de
    config.i18n.available_locales = [:en, :fr]
    config.i18n.default_locale = :en

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "UTF-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Use SQL instead of Active Record"s schema dumper when creating the database.
    # This is necessary if your schema can"t be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    config.active_record.schema_format = :sql

    # Enable the asset pipeline
    config.assets.enabled = true

    config.assets.initialize_on_precompile = true

    # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
    config.assets.precompile += ["public.css", "mailer.css", "public.js"]

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = "1.0"

    config.i18n.enforce_available_locales = false

    config.middleware.delete Rack::Lock
    config.middleware.use FayeRails::Middleware, mount: '/faye', :timeout => 25
    # config.middleware.use FayeRails::Middleware, extensions: [CsrfProtection.new], mount: '/faye', :timeout => 25

    # Devise controller layouts
    config.to_prepare do
      Devise::SessionsController.layout "app_small"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "app_full" : "app_small" }
      Devise::ConfirmationsController.layout "app_small"
      Devise::UnlocksController.layout "app_small"
      Devise::PasswordsController.layout "app_small"
      Devise::Mailer.layout "mailer"
    end
  end
end
