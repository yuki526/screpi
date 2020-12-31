require 'rails_helper'

RSpec.describe "レシピ投稿", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @recipe = FactoryBot.build(:form_recipe_ingredient)
  end

  content 'レシピ新規投稿ができる時' do
    it 'ログインしたユーザーはレシピの新規投稿ができる' do
      # ログインする
      # 新規投稿ページへのリンクがあることを確認する
      # 投稿ページに移動する
      # フォームに情報を入力する
      # 送信するとTweetモデルのカウントが1上がることを確認する
      # 投稿完了ページに遷移することを確認する
      # 「投稿が完了しました」の文字があることを確認する
      # トップページに遷移する
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
    end
  end

  
end
