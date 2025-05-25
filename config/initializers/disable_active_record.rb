# Completely disable ActiveRecord
unless defined?(ActiveRecord)
  module ActiveRecord
    class Base
    end
    
    class Migration
      class CheckPending
      end
    end
  end
end 