class RecipesController < ApplicationController
  before_action :authenticate, only: [:mypage, :new, :create, :destroy]

  def index
    @new_videos = Recipe.where(site_type_id: 2).order("created_at DESC").limit(3)
    @new_recipes = Recipe.where.not(site_type_id: 2).order("created_at DESC").page(params[:page]).per(5)
    @new_blogs = Blog.order("created_at DESC").limit(5).includes(:user)
  end
  
  def about
  end
  
  def mypage
    @my_recipes = Recipe.where(user_id: current_user).order("created_at DESC").page(params[:page]).per(5)
    @my_blogs = Blog.where(user_id: current_user).order("created_at DESC").page(params[:page]).per(5)
    @favorite_recipes = FavoriteRecipe.where(user_id: current_user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @form_recipe_ingredient = FormRecipeIngredient.new
  end
  
  def create
    # 素材を配列に格納
    ingredients_split

    @form_recipe_ingredient = FormRecipeIngredient.new(recipe_params)
    unless @form_recipe_ingredient.valid?
      redirect_to new_recipe_path, flash: {notice: "正しく入力されていません"} and return
    end
    # youtubeの場合はURLを加工
    if @form_recipe_ingredient.site_type_id == "2"
      @form_recipe_ingredient.url = @form_recipe_ingredient.url.last(11)
    end
    @form_recipe_ingredient.save
    redirect_to root_path and return
  end

  def show
    @recipe = Recipe.includes(:user).find(params[:id])
    @ingredients = @recipe.ingredients
    @comment = RecipeComment.new
    @comments = RecipeComment.where(recipe_id: @recipe.id).order("created_at DESC")
    @blogs = Blog.where(recipe_id: @recipe.id).order("created_at DESC")
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to mypage_recipe_path(current_user.id)
  end


  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def recipe_params
    params.require(:form_recipe_ingredient).permit(:title, :url, :site_type_id, :effort_level_id, :content, name: []).merge(user_id: current_user.id)
  end

  def ingredients_split
    params[:form_recipe_ingredient][:name] = params[:form_recipe_ingredient][:name].split("、")
  end

end
