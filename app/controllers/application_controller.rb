class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  include Authenticable
  include Paginable
  rescue_from CanCan::AccessDenied do |exception|
    render json: { message: exception.message }, status: 403
  end
end
