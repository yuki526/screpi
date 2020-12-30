class FavoriteRecipesController < ApplicationController
  before_action :authenticate

  def new
    @recipe = Recipe.includes(:user).find(params[:recipe_id])
    @ingredients = @recipe.ingredients
    @favorite_recipe = FavoriteRecipe.new
    if @recipe.user.id == current_user.id
      redirect_to recipe_path(@recipe.id) and return
    end
  end

  
  def create
    # 元のレシピを呼び出し、お気に入りレシピ登録のインスタンスを生成
    original_recipe = Recipe.find(params[:favorite_recipe][:recipe_id])
    recipe = FavoriteRecipe.new(favorite_recipe_params)

    # お気に入りに登録済の場合は追加ページへ戻す
    if FavoriteRecipe.find_by(recipe_id: original_recipe.id)
      @recipe = original_recipe
      @ingredients = @recipe.ingredients
      redirect_to new_favorite_recipe_path(recipe_id: @recipe.id), flash: {notice: "お気に入りに登録済レシピです"} and return
    end

    # お気に入りレシピの各項目設定
    favorite_recipe = recipe.set_favorite_recipe(recipe, original_recipe, current_user.id)

    # 入力に不正がある場合は追加ページへ戻す
    unless favorite_recipe.valid?
      @recipe = original_recipe
      @ingredients = @recipe.ingredients
      redirect_to new_favorite_recipe_path(recipe_id: @recipe.id), flash: {notice: "正しく入力されていません"} and return
    end

    # お気に入りレシピ登録
    favorite_recipe.save
    
    # 登録済お気に入りレシピidを使って素材と中間テーブルの登録
    FavoriteRecipeIngredient.set_favorite_recipe_ingredients(favorite_recipe, original_recipe)

    redirect_to mypage_recipe_path(current_user.id)
  end


  def show
    @recipe = FavoriteRecipe.includes(:user).find(params[:id])
    @ingredients = FavoriteRecipeIngredient.set_ingredient(@recipe)
  end


  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def favorite_recipe_params
    params.require(:favorite_recipe).permit(:effort_level_id, :content, recipe_id: params[:recipe_id]).merge(user_id: current_user.id)
  end

end