# frozen_string_literal: true

class Librarians::SessionsController < ApplicationController
  # Skip CSRF verification for the demo
  skip_before_action :verify_authenticity_token
  
  def new
    # Login form
  end
  
  def create
    # Find librarian by email
    @librarian = Librarian.find_by(email: params[:librarian][:email])
    
    # Check if librarian exists and password matches
    if @librarian && @librarian.valid_password?(params[:librarian][:password])
      # Set session
      session[:librarian_id] = @librarian.id
      
      # Redirect to librarian dashboard
      redirect_to root_path, notice: "Logged in successfully as librarian."
    else
      # Show error
      flash.now[:alert] = "Invalid email or password."
      render :new
    end
  end
  
  def destroy
    # Clear session
    session[:librarian_id] = nil
    
    # Redirect to home page
    redirect_to root_path, notice: "Logged out successfully."
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
