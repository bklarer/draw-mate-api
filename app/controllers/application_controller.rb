class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?

    def health_check
        render json: { status: 'ok', message: 'API is up and running!', timestamp: Time.now }
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name timezone])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name timezone])
    end

end
