class ApplicationController < ActionController::API
    def health_check
        render json: { status: 'ok', message: 'API is up and running!', timestamp: Time.now }
    end
end
