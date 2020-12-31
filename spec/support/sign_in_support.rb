module SignInSupport
  def sign_in(user)
    # トップページに移動する
    visit root_path

    # 正しいユーザー情報を入力する
    fill_in 'login_email', with: @user.email
    fill_in 'login_password', with: @user.password

    # ログインボタンを押す
    find('input[name="commit"]').click

    # トップページへ遷移する
    expect(current_path).to eq root_path
  end
end