# This initializer handles setup for a Rails app without a database

# Override SchemaMigration to prevent database access
if defined?(ActiveRecord::SchemaMigration)
  class << ActiveRecord::SchemaMigration
    def table_exists?
      # Always return true to bypass migration checks
      true
    end
    
    def create_table
      # No-op, avoid creating actual table
      true
    end
  end
end

# Define a method to prevent Rails from trying to connect to a database
if defined?(ActiveRecord::Base)
  class << ActiveRecord::Base
    # Override establish_connection to prevent actual connection attempts
    def establish_connection(*args)
      # This is a no-op implementation
      Rails.logger.debug("Database connection attempt prevented - running in no-database mode") if defined?(Rails.logger)
    end
    
    # Override connection to return a dummy connection object
    def connection
      # Return a dummy connection object that responds to common methods
      DummyConnection.new
    end
    
    # Define a dummy connection class
    class DummyConnection
      def execute(sql)
        [] # Return empty result for any SQL execution
      end
      
      def select_values(sql)
        [] # Return empty values for any SQL selection
      end
      
      def method_missing(method, *args)
        # Handle any other method calls gracefully
        []
      end
      
      def respond_to_missing?(method, include_private = false)
        true # Respond to all methods
      end
    end
  end
end

# Prevent Rails from checking migrations
if defined?(ActiveRecord::Migration)
  class << ActiveRecord::Migration
    def check_pending!
      # No-op, avoid checking migrations
    end
  end
end 