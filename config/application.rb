require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MelziRails
  class Application < Rails::Application
    config.load_defaults 6.1

    # https://github.com/sass/sassc-ruby/issues/207
    config.assets.configure do |env|
      env.export_concurrent = false
    end

    config.active_job.queue_adapter = :sidekiq
  end
end
