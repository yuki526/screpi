require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path

      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'user_name', with: @user.name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      choose  'user_user_icon_id_3'

      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{find('input[name="sign-up-commit"]').click}.to change { User.count }.by(1)

      # トップページへ遷移する
      expect(current_path).to eq root_path

      # 画面上部にとログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')

      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')

    end
  end


  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path

      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')

      # 新規登録ページへ移動する
      visit new_user_registration_path

      # ユーザー情報を入力する
      fill_in 'user_name', with: ""
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""
      choose  'user_user_icon_id_3'

      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{find('input[name="sign-up-commit"]').click}.to change { User.count }.by(0)

      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end

end
