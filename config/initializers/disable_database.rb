# This file disables database operations for the current session
# This is a temporary solution to allow the website to run without a configured database

if ENV['SKIP_DB'] == 'true'
  Rails.application.config.to_prepare do
    # Monkey patch ActiveRecord::Base to prevent database operations
    ActiveRecord::Base.class_eval do
      def self.establish_connection(*args)
        # Do nothing to prevent database connection
      end
    end
  end
end 