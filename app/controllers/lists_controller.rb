class ListsController < ApplicationController
  before_action :authenticate

  def create
    ingredient= Ingredient.where(list_params).first_or_create
    list = List.create(user_id: current_user.id, ingredient_id: ingredient.id)
    render json:{ name: list.ingredient.name } 
  end

  def destroy 
    list = List.find(params[:id])
    list.destroy
    redirect_to root_path
    # render json {list: list}
  end



  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def list_params
    params.require(:ingredient).permit(:name)
  end
end
