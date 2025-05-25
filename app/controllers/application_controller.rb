class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { Rails.application.config.mock_data }
  
  # Include our authentication helpers
  include ApplicationHelper
  
  # Add flash message types
  add_flash_types :success, :info, :warning, :danger
  
  # Rescue from ActiveRecord::RecordNotFound with a 404 page
  rescue_from Exception, with: :handle_exception if Rails.application.config.mock_data
  
  private
  
  def handle_exception(exception)
    # For demo purposes, we'll just show a friendly error page for all exceptions
    case exception
    when ActionController::RoutingError, ActionController::UnknownController, ActionController::UnknownAction
      render template: 'errors/not_found', status: 404
    else
      # Log the error
      Rails.logger.error("Error: #{exception.message}")
      
      # Show a generic error page
      render template: 'errors/internal_server_error', status: 500
    end
    true
  end
end
