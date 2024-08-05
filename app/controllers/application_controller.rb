class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { error: exception.message }, status: :bad_request
  end
end
