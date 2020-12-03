class ApplicationController < ActionController::Base
  before_action :configre_permitted_parameters, if: :devise_controller?
  before_action :authenticate 

def authenticate
  redirect_to root_path unless user_signed_in?
end

  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
  end
end
