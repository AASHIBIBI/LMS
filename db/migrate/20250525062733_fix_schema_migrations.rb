class FixSchemaMigrations < ActiveRecord::Migration[5.2]
  def up
    # Get a list of all migration files
    migration_files = Dir.glob(Rails.root.join('db', 'migrate', '*.rb'))
    
    # Extract the version numbers from the filenames
    versions = migration_files.map do |file|
      File.basename(file)[/\A(\d+)_/, 1]
    end.compact
    
    # Insert the versions into schema_migrations
    versions.each do |version|
      # Skip if already in the schema_migrations table
      next if ActiveRecord::Base.connection.select_value("SELECT version FROM schema_migrations WHERE version = '#{version}'")
      
      # Insert the version
      ActiveRecord::Base.connection.execute(
        "INSERT INTO schema_migrations (version) VALUES ('#{version}')"
      )
    end
  end
  
  def down
    # This migration is irreversible
  end
end
