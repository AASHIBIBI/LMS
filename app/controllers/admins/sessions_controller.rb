# frozen_string_literal: true

class Admins::SessionsController < ApplicationController
  # Skip CSRF verification for the demo
  skip_before_action :verify_authenticity_token
  
  def new
    # Login form
  end
  
  def create
    # Find admin by email
    @admin = Admin.find_by(email: params[:admin][:email])
    
    # Check if admin exists and password matches
    if @admin && @admin.valid_password?(params[:admin][:password])
      # Set session
      session[:admin_id] = @admin.id
      
      # Redirect to admin dashboard
      redirect_to root_path, notice: "Logged in successfully as admin."
    else
      # Show error
      flash.now[:alert] = "Invalid email or password."
      render :new
    end
  end
  
  def destroy
    # Clear session
    session[:admin_id] = nil
    
    # Redirect to home page
    redirect_to root_path, notice: "Logged out successfully."
  end

  # protected
  def after_sign_in_path_for(resource)
    '/admins'
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
