require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context "新規ユーザー登録ができる時" do
      it "すべての項目が正しく存在すれば登録できること" do
        expect(@user).to be_valid
      end
    end

    context "新規ユーザー登録ができない時" do
      it "名前が空では登録できないこと" do
        @user.name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it "名前が21文字以上では登録できないこと" do
        @user.name = "あいうえおかきくけこさしすせそたちつてとな"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は20文字以内で入力してください")
      end
  
      it "Eメールが空では登録できないこと" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
  
      it "重複したEメールが存在する場合登録できないこと" do
        another_user = FactoryBot.build(:user)
        another_user.save
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールはすでに存在します")
      end
  
      it "Eメールが@を含んでいない場合登録できないこと" do
        @user.email = "aaaaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
  
      it "passwordが空では登録できないこと" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
  
      it "passwordが５文字以下の場合登録できないこと" do
        @user.password = "123ab"
        @user.password_confirmation = "123ab"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
  
      it "passwordが半角英字のみの場合登録できないこと" do
        @user.password = "abcdef"
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数混合で入力してください")
      end
  
      it "passwordが半角数字のみの場合登録できないこと" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数混合で入力してください")
      end
  
      it "passwordとpassword_confirmationが不一致では登録できないこと" do
        @user.password = "1234abcd"
        @user.password_confirmation = "abcd1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it "ユーザーアイコンが選択されていないと出品できないこと" do
        @user.user_icon_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ユーザーアイコンを入力してください")
      end

    end
  end
end
