# frozen_string_literal: true

class Students::SessionsController < ApplicationController
  # Skip CSRF verification for the demo
  skip_before_action :verify_authenticity_token
  
  def new
    # Login form
  end
  
  def create
    # Find student by email
    @student = Student.find_by(email: params[:student][:email])
    
    # Check if student exists and password matches
    if @student && @student.valid_password?(params[:student][:password])
      # Set session
      session[:student_id] = @student.id
      
      # Redirect to student dashboard
      redirect_to root_path, notice: "Logged in successfully as student."
    else
      # Show error
      flash.now[:alert] = "Invalid email or password."
      render :new
    end
  end
  
  def destroy
    # Clear session
    session[:student_id] = nil
    
    # Redirect to home page
    redirect_to root_path, notice: "Logged out successfully."
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
