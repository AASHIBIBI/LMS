class WelcomeController < ApplicationController
  # Skip authentication for the welcome page
  skip_before_action :verify_authenticity_token, only: [:index]
  
  def index
    # Just render the index view
  end
end
