class FormRecipeIngredient
  include ActiveModel::Model
  attr_accessor :title, :url, :site_type_id, :effort_level_id, :content, :user_id, :name

  with_options presence: true do
    validates :title, length: { maximum: 20 }
    validates :url
    validates :site_type_id
    validates :effort_level_id
    validates :name
  end

  def save
    #材料以外のレシピデータを保存
    recipe = Recipe.create(title: title, url: url, site_type_id: site_type_id,
                          effort_level_id: effort_level_id, content: content,user_id: user_id)

    # 材料を一つずつ登録or既存データを取り出し、idを配列に格納
    ingredients_array = Array.new
    name.each do |n|
      ingredient = Ingredient.where(name: n).first_or_create
      ingredients_array << ingredient.id
    end

    #中間テーブルにレコード作成
    ingredients_array.each do |i|
      RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: i)
    end

    return recipe.id
  end

end