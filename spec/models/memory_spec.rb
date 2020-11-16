require 'rails_helper'

RSpec.describe Memory, type: :model do
  let(:memory) { create(:memory) }

  describe 'validations' do
    # タイトル、メッセージ、行事日、画像があれば有効な状態であること
    it "is valid with a title, message, event_date and image0" do
      expect(memory).to be_valid
    end

    # タイトルがなければ無効な状態であること
    it "is invalid without a title" do
      memory.title = ''
      memory.valid?
      expect(memory.errors[:title]).to include("を入力してください")
    end

    # タイトルが20文字以上であれば登録できないこと
    it "is invalid if the title is longer than 20 characters" do
      memory.title = "あ" * 21
      memory.valid?
      expect(memory.errors[:title]).to include("は20文字以内で入力してください")
    end

    # メッセージがなければ無効な状態であること
    it "is invalid without a message" do
      memory.message = ''
      memory.valid?
      expect(memory.errors[:message]).to include("を入力してください")
    end

    # 行事日がなければ無効な状態であること
    it "is invalid without a event_date" do
      memory.event_date = ''
      memory.valid?
      expect(memory.errors[:event_date]).to include("を入力してください")
    end

    # 画像がなければ無効な状態であること
    it "is invalid without a image0" do
      memory.image0 = ''
      memory.valid?
      expect(memory.errors[:image0]).to include("を入力してください")
    end
  end
end
