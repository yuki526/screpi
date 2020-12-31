require 'rails_helper'

RSpec.describe FavoriteRecipe, type: :model do
  describe '#save' do
    before do
      @user = FactoryBot.create(:user)
      @recipe = FactoryBot.create(:recipe, user_id: @user.id)
      @favorite_recipe = FactoryBot.build(:favorite_recipe, user_id: @user.id, recipe_id: @recipe.id)
    end

    context "お気に入りレシピ登録ができる時" do
      it "すべての項目が正しく存在すれば登録できること" do
        expect(@favorite_recipe).to be_valid
      end

      it "お気に入りレシピ本文が空でも投稿できること" do
        @favorite_recipe.content = nil
        expect(@favorite_recipe).to be_valid
      end

    end

    context "お気に入りレシピ登録ができない時" do
      it "タイトルが空では登録できないこと" do
        @favorite_recipe.title = nil
        @favorite_recipe.valid?
        expect(@favorite_recipe.errors.full_messages).to include("タイトルを入力してください")
      end

      it "タイトルが21文字以上では登録できないこと" do
        @favorite_recipe.title = "あいうえおかきくけこさしすせそたちつてとな"
        @favorite_recipe.valid?
        expect(@favorite_recipe.errors.full_messages).to include("タイトルは20文字以内で入力してください")
      end

      it "URLが空では登録できないこと" do
        @favorite_recipe.url = nil
        @favorite_recipe.valid?
        expect(@favorite_recipe.errors.full_messages).to include("URLを入力してください")
      end

      it "サイト情報が選択されていないと登録できないこと" do
        @favorite_recipe.site_type_id = nil
        @favorite_recipe.valid?
        expect(@favorite_recipe.errors.full_messages).to include("サイト情報を入力してください")
      end

      it "手間度が選択されていないと登録できないこと" do
        @favorite_recipe.effort_level_id = nil
        @favorite_recipe.valid?
        expect(@favorite_recipe.errors.full_messages).to include("手間度を入力してください")
      end
    end
  end
end
