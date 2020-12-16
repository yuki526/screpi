class FavoriteRecipesController < ApplicationController
  before_action :authenticate

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = @recipe.ingredients
    @favorite_recipe = FavoriteRecipe.new
  end

  
  def create
    # 元のレシピを呼び出し、お気に入りレシピ登録のインスタンスを生成
    original_recipe = Recipe.find(params[:favorite_recipe][:recipe_id])
    recipe = FavoriteRecipe.new(favorite_recipe_params)

    # お気に入りレシピの各項目設定
    favorite_recipe = set_favorite_recipe(recipe, original_recipe)

    # 素材以外の入力が正しいか（favorite_recipeに登録できるか）チェック
    unless favorite_recipe.valid?
      @recipe = original_recipe
      @ingredients = @recipe.ingredients
      redirect_to new_favorite_recipe_path(recipe_id: @recipe.id) and return
    end

    # お気に入りレシピ登録
    favorite_recipe.save
    
    # 登録済お気に入りレシピidを使って素材と中間テーブルの登録
    set_favorite_recipe_ingredients(favorite_recipe, original_recipe)

    redirect_to mypage_recipe_path(current_user.id)
  end


  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def favorite_recipe_params
    params.require(:favorite_recipe).permit(:effort_level_id, :content, recipe_id: params[:recipe_id]).merge(user_id: current_user.id)
  end

  def set_favorite_recipe(favorite_recipe, original_recipe)

    # 各項目をセット（素材以外）
    favorite_recipe.title = original_recipe.title
    favorite_recipe.url = original_recipe.url
    favorite_recipe.site_type_id = original_recipe.site_type_id
    favorite_recipe.recipe_id = original_recipe.id
    favorite_recipe.user_id = current_user.id

    favorite_recipe
  end
  
  def set_favorite_recipe_ingredients(favorite_recipe, original_recipe)

    # 材料を一つずつ登録or既存データを取り出し、idを配列に格納
    ingredients_array = Array.new
    original_recipe.ingredients.each do |i|
      ingredient = i[:id]
      ingredients_array << ingredient
    end

    #中間テーブルにレコード作成
    ingredients_array.each do |i|
      FavoriteRecipeIngredient.create(favorite_recipe_id: favorite_recipe.id, ingredient_id: i)
    end
  end

end