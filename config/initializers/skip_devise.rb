# Skip Devise authentication for now
Rails.application.config.to_prepare do
  Devise::SessionsController.skip_before_action :verify_authenticity_token, raise: false
  Devise::RegistrationsController.skip_before_action :verify_authenticity_token, raise: false
  Devise::PasswordsController.skip_before_action :verify_authenticity_token, raise: false
end 