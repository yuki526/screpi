class ListsController < ApplicationController
  before_action :authenticate

  def create
    ingredient = Ingredient.where(name: params[:name]).first_or_create
    list = List.create(user_id: current_user.id, ingredient_id: ingredient.id)
    render json:{ name: list.ingredient.name }
    
  end



  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end
end
