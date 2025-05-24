class WelcomeController < ApplicationController
  # Skip database verification
  skip_before_action :verify_authenticity_token, only: [:index]
  
  def index
    # This is a simple action that doesn't require database access
  end
end
