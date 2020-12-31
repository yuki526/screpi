require 'rails_helper'

RSpec.describe RecipeComment, type: :model do
  describe '#create' do
    before do 
      @user = FactoryBot.create(:user)
      @comment_user = FactoryBot.create(:user, email: 'aaa@aaa')
      @recipe = FactoryBot.create(:recipe, user_id: @user.id)
      @recipe_comment = FactoryBot.build(:recipe_comment, user_id:@comment_user.id, recipe_id: @recipe.id)
    end

    context "コメント投稿ができる時" do
      it "本文を入力すれば投稿できること" do
        expect(@recipe_comment).to be_valid
      end
    end

    context "コメント投稿ができない時" do
      it "本文が空では投稿できない" do
        @recipe_comment.text = nil
        @recipe_comment.valid?
        expect(@recipe_comment.errors.full_messages).to include("本文を入力してください")
      end

      it "本文が101文字以上だと投稿できない" do
        @recipe_comment.text = "あ" * 101
        @recipe_comment.valid?
        expect(@recipe_comment.errors.full_messages).to include("本文は100文字以内で入力してください")
      end
    end

  end
end
