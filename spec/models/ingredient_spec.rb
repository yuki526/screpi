require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe '素材名登録の時' do
    before do
      @ingredient = FactoryBot.build(:ingredient)
    end

    context "素材名登録ができる時" do
      it "素材名が存在すれば登録できること" do
        expect(@ingredient).to be_valid
      end
    end

    context "素材名登録ができない時" do
      it "素材名が空では登録できないこと" do 
        @ingredient.name = nil
        @ingredient.valid?
        expect(@ingredient.errors.full_messages).to include("素材名を入力してください")
      end

      it "素材名が11文字以上では登録できないこと" do 
        @ingredient.name = "あいうえおかきくけこた"
        @ingredient.valid?
        expect(@ingredient.errors.full_messages).to include("素材名は10文字以内で入力してください")
      end
    end
  end

end
