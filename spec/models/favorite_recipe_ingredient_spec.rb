require 'rails_helper'

###########################
#うまくいかないのでいったんほうち12/31
##########################

RSpec.describe FavoriteRecipeIngredient, type: :model do
  describe 'set_ingredient(recipe)' do
    it "レシピに含まれる素材名を配列で返す" do
      @recipe = FormRecipeIngredient.new(
        title:  "test-title", 
        url:  "https://testurl.com",
        site_type_id:  3,
        effort_level_id:  3, 
        content: "テスト内容テスト内容テスト内容テスト内容テスト内容テスト内容", 
        name: ["にんじん", "じゃがいも", "玉ねぎ"]
      )
      @recipe.save
      correct_array = ["にんじん", "じゃがいも", "玉ねぎ"]
      expect(FavoriteRecipeIngredient.set_ingredient(@recipe)).to eq(correct_array)
    end

  end
end
