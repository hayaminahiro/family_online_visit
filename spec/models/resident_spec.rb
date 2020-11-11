require 'rails_helper'

RSpec.describe Resident, type: :model do
  let(:resident) { create(:resident) }

  describe 'validations' do
    # 名前、担当者名があれば有効な状態であること
    it "is valid with a name and charge_worker" do
      expect(resident).to be_valid
    end

    # 名前がなければ無効な状態であること
    it "is invalid without a name" do
      resident.name = ''
      resident.valid?
      expect(resident.errors[:name]).to include("を入力してください")
    end

    # 名前が20文字以上であれば登録できないこと
    it "is invalid if the name is longer than 50 characters" do
      resident.name = "あ" * 21
      resident.valid?
      expect(resident.errors[:name]).to include("は20文字以内で入力してください")
    end

    # 担当者名がなければ無効な状態であること
    it "is invalid without a charge_worker" do
      resident.charge_worker = ''
      resident.valid?
      expect(resident.errors[:charge_worker]).to include("を入力してください")
    end

    # 担当者名が20文字以上であれば登録できないこと
    it "is invalid if the charge_worker is longer than 50 characters" do
      resident.charge_worker = "あ" * 21
      resident.valid?
      expect(resident.errors[:charge_worker]).to include("は20文字以内で入力してください")
    end
  end
end
