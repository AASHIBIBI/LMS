class ErrorsController < ApplicationController
  # Skip authentication for error pages
  skip_before_action :verify_authenticity_token
  
  def not_found
    render status: 404
  end
  
  def internal_server_error
    render status: 500
  end
end 