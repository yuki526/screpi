require 'rails_helper'

RSpec.describe "レシピ投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @recipe = FactoryBot.create(:recipe, user_id: @user.id)
  end

  context 'レシピ新規投稿ができる時' do
    it 'ログインしたユーザーはレシピの新規投稿ができる' do
      # ログインする
      sign_in(@user)

      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('レシピ追加')

      # 投稿ページに移動する
      visit new_recipe_path

      # フォームに情報を入力する
      fill_in 'form_recipe_ingredient_title', with: @recipe.title
      fill_in 'form_recipe_ingredient_url', with: @recipe.url
      fill_in 'form_recipe_ingredient_name', with: "たまねぎ、にんじん、じゃがいも"
      select 'クラシル', from: 'form_recipe_ingredient_site_type_id'
      select '☆☆', from: 'form_recipe_ingredient_effort_level_id'

      # 送信するとRecipeモデルのカウントが1上がることを確認する
      expect{find('input[name="commit"]').click}.to change { Recipe.count }.by(1)

      # レシピ詳細ページには投稿したレシピのタイトルが存在する
      expect(page).to have_content(@recipe.title)
    end
  end

  context 'レシピ投稿ができない時' do
    it 'ログインしていないとレシピ新規投稿ページに遷移できない' do
      # 新規投稿ページに遷移する
      visit new_recipe_path
      # 新規投稿ページへは遷移できず、トップページへ戻る
      expect(current_path).to eq root_path
    end
  end
end


RSpec.describe "レシピ詳細", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @recipe = FactoryBot.create(:recipe, user_id: @user.id)
  end

  it 'ログインしたユーザーはレシピ詳細ページに遷移してコメント投稿欄・コミュニケーション欄が表示される' do
    # ログインする
    sign_in(@recipe.user)

    # レシピの詳細ページへ遷移する
    visit recipe_path(@recipe)

    # レシピ詳細ページにてレシピのタイトルと投稿ユーザー名が確認できる
    expect(page).to have_content("#{@recipe.title}")
    expect(page).to have_content("#{@recipe.user.name}")

    # コメント用のフォームが存在する
    expect(page).to have_selector '.comment-add-form'

    # いいねボタン、お気に入りボタン、ブログボタンが存在する
    expect(page).to have_selector '.communications'
  end

  it 'ログインしていないユーザーはレシピ詳細ページに遷移できるがコメント投稿欄・コミュニケーション欄は表示されない' do
    # レシピの詳細ページへ遷移する
    visit recipe_path(@recipe)

    # レシピ詳細ページにてレシピのタイトルと投稿ユーザー名が確認できる
    expect(page).to have_content("#{@recipe.title}")
    expect(page).to have_content("#{@recipe.user.name}")

    # コメント用のフォームが存在しない
    expect(page).to have_no_selector '.comment-add-form'

    # いいねボタン、お気に入りボタン、ブログボタンが存在しない
    expect(page).to have_no_selector '.communications'
  end
end


RSpec.describe "レシピ削除", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user, email: 'aaa@aaa')
    @recipe = FactoryBot.create(:recipe, user_id: @user.id)
    @another_recipe = FactoryBot.create(:recipe, user_id: @another_user.id)
  end

  context 'レシピ削除ができる時' do
    it 'ログインしたユーザーは自分が投稿したレシピの削除ができる' do
      # レシピを投稿したユーザーでログインする
      sign_in(@recipe.user)

      # レシピの詳細ページへ遷移する
      visit recipe_path(@recipe)

      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{find_link('delete', href: recipe_path(@recipe)).click}.to change { Recipe.count }.by(-1)

      # マイページに遷移する
      expect(current_path).to eq mypage_recipe_path(@user)

      # マイページにはレシピのタイトルが存在しないことを確認する
      expect(page).to have_no_content("#{@recipe.title}")
    end
  end

  context 'レシピ削除ができない時' do
    it 'ログインしたユーザーは自分以外が投稿したレシピの削除ができない' do
      # レシピを投稿したユーザーとは別のユーザーでログインする
      sign_in(@user)

      # レシピの詳細ページへ遷移する
      visit recipe_path(@another_recipe)

      # 「delete」ボタンが無いことを確認する
      expect(page).to have_no_link "delete", href: recipe_path(@recipe)
    end

    it 'ログインしていないユーザーは「delete」ボタンがない' do
      # レシピの詳細ページへ遷移する
      visit recipe_path(@recipe)

      # 「delete」ボタンが無いことを確認する
      expect(page).to have_no_link "delete", href: recipe_path(@recipe)
    end
  end
end

