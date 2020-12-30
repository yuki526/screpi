require 'rails_helper'

RSpec.describe FormRecipeIngredient, type: :model do
  before do
    @form_recipe_ingredient = FactoryBot.build(:form_recipe_ingredient)
  end

  context "レシピ投稿ができる時" do
    it "すべての項目が正しく存在すれば投稿できること" do
      expect(@form_recipe_ingredient).to be_valid
    end
    
    it "レシピ本文が空でも投稿できること" do
      @form_recipe_ingredient.content = nil
      expect(@form_recipe_ingredient).to be_valid
    end

  end

  context "レシピ投稿ができない時" do
    it "タイトルが空では登録できないこと" do
      @form_recipe_ingredient.title = nil
      @form_recipe_ingredient.valid?
      expect(@form_recipe_ingredient.errors.full_messages).to include("タイトルを入力してください")
    end
    
    it "タイトルが21文字以上では登録できないこと" do
      @form_recipe_ingredient.title = "あいうえおかきくけこさしすせそたちつてとな"
      @form_recipe_ingredient.valid?
      expect(@form_recipe_ingredient.errors.full_messages).to include("タイトルは20文字以内で入力してください")
    end

    it "URLが空では登録できないこと" do
      @form_recipe_ingredient.url = nil
      @form_recipe_ingredient.valid?
      expect(@form_recipe_ingredient.errors.full_messages).to include("URLを入力してください")
    end

    it "サイト情報が選択されていないと登録できないこと" do
      @form_recipe_ingredient.site_type_id = nil
      @form_recipe_ingredient.valid?
      expect(@form_recipe_ingredient.errors.full_messages).to include("サイト情報を入力してください")
    end

    it "手間度が選択されていないと登録できないこと" do
      @form_recipe_ingredient.effort_level_id = nil
      @form_recipe_ingredient.valid?
      expect(@form_recipe_ingredient.errors.full_messages).to include("手間度を入力してください")
    end

    it "素材名が空では登録できないこと" do
      @form_recipe_ingredient.name = nil
      @form_recipe_ingredient.valid?
      expect(@form_recipe_ingredient.errors.full_messages).to include("素材名を入力してください")
    end


  end
end
