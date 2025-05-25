# Completely disable ActiveStorage
Rails.application.config.after_initialize do
  # Define empty ActiveStorage module if not defined to prevent errors
  unless defined?(ActiveStorage)
    module ActiveStorage
      class Attachment
      end
      
      class Blob
      end
      
      module Downloading
      end
      
      module Purge
      end
    end
  end
end 