class ApplicationController < ActionController::Base
  before_action :configre_permitted_parameters, if: :devise_controller?
  before_action :set_list


  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
  end

  def set_list
    @ingredient = Ingredient.new
    @lists = List.where(user_id: current_user.id).includes(:ingredient)
  end
  
end
