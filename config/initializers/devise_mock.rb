# Mock implementation for Devise authentication

module Devise
  module Models
    module Authenticatable
      def valid_password?(password)
        # For demo purposes, always accept 'password' as valid
        password == 'password'
      end
    end
  end
  
  module Controllers
    module Helpers
      def authenticate_student!
        # This is a simplified authentication check
        # In a real app, this would check the session or JWT token
        true
      end
      
      def authenticate_librarian!
        true
      end
      
      def authenticate_admin!
        true
      end
      
      def current_student
        # For demo, always return the first student
        Student.find(1)
      end
      
      def current_librarian
        Librarian.find(1)
      end
      
      def current_admin
        Admin.find(1)
      end
      
      def student_signed_in?
        true
      end
      
      def librarian_signed_in?
        true
      end
      
      def admin_signed_in?
        true
      end
    end
  end
  
  class Mapping
    def self.find_scope!(obj)
      if obj.is_a?(Student)
        :student
      elsif obj.is_a?(Librarian)
        :librarian
      elsif obj.is_a?(Admin)
        :admin
      else
        :student # default
      end
    end
  end
  
  # Mock the Devise::Test module for sign in/out actions
  module Test
    module ControllerHelpers
      def sign_in(resource)
        # No-op
      end
      
      def sign_out(resource)
        # No-op
      end
    end
  end
end

# Make sure controllers include the Devise helpers
ActionController::Base.include Devise::Controllers::Helpers 