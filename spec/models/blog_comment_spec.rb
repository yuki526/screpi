require 'rails_helper'

RSpec.describe BlogComment, type: :model do
  describe '#create' do
    before do 
      @user = FactoryBot.create(:user)
      @comment_user = FactoryBot.create(:user, email: 'aaa@aaa')
      @recipe = FactoryBot.create(:recipe, user_id: @user.id)
      @blog = FactoryBot.create(:blog, user_id: @user.id, recipe_id: @recipe.id)
      @blog_comment = FactoryBot.build(:blog_comment, user_id:@comment_user.id, blog_id: @blog.id)
    end

    context "コメント投稿ができる時" do
      it "本文を入力すれば投稿できること" do
        expect(@blog_comment).to be_valid
      end
    end

    context "コメント投稿ができない時" do
      it "本文が空では投稿できない" do
        @blog_comment.text = nil
        @blog_comment.valid?
        expect(@blog_comment.errors.full_messages).to include("本文を入力してください")
      end

      it "本文が101文字以上だと投稿できない" do
        @blog_comment.text = "あ" * 101
        @blog_comment.valid?
        expect(@blog_comment.errors.full_messages).to include("本文は100文字以内で入力してください")
      end
    end

  end
end
