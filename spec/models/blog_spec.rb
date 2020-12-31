require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.create(:user)
      @recipe = FactoryBot.create(:recipe, user_id: @user.id)
      @blog = FactoryBot.build(:blog, user_id: @user.id, recipe_id: @recipe.id)
    end

    context "ブログ投稿ができる時" do
      it "すべての項目が正しく存在すれば登録できること" do
        expect(@blog).to be_valid
      end
    end

    context "ブログ投稿ができない時" do
      it "タイトルが空では投稿できない" do
        @blog.title = nil
        @blog.valid?
        expect(@blog.errors.full_messages).to include("タイトルを入力してください")
      end

      it "タイトルが21文字以上では登録できない" do
        @blog.title = "あいうえおかきくけこさしすせそたちつてとな"
        @blog.valid?
        expect(@blog.errors.full_messages).to include("タイトルは20文字以内で入力してください")
      end

      it "本文が空では投稿できない" do
        @blog.content = nil
        @blog.valid?
        expect(@blog.errors.full_messages).to include("本文を入力してください")
      end
    end
  end
end
