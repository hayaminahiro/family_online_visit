require 'rails_helper'

RSpec.describe Information, type: :model do
  let(:information) { create(:information) }

  describe 'validations' do
    # タイトル、本文があれば有効な状態であること
    it "is valid with a name, email, and password" do
      expect(information).to be_valid
    end

    # タイトルがなければ無効な状態であること
    it "is invalid without a title" do
      information.title = ''
      information.valid?
      expect(information.errors[:title]).to include("を入力してください")
    end

    # 本文がなければ無効な状態であること
    it "is invalid without a news" do
      information.news = ''
      information.valid?
      expect(information.errors[:news]).to include("を入力してください")
    end
  end
end
