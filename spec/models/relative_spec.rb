require 'rails_helper'

RSpec.describe Relative, type: :model do
  let(:user) { create(:user) }
  let(:resident) { create(:resident) }

  describe "presence of user_id and resident_id" do
    # user_id、resident_idがあれば有効な状態であること
    it "is valid with a user_id" do
      facility_user = Relative.new(user_id: user.id, resident_id: resident.id)
      expect(facility_user).to be_valid
    end

    # user_idがなければ無効な状態であること
    it "is invalid without a user_id" do
      facility_user = Relative.new(user_id: nil, resident_id: resident.id)
      facility_user.valid?
      expect(facility_user.errors[:user]).to include("を入力してください")
    end

    # resident_idがなければ無効な状態であること
    it "is invalid without a resident_id" do
      facility_user = Relative.new(resident_id: nil, user_id: user.id)
      facility_user.valid?
      expect(facility_user.errors[:resident]).to include("を入力してください")
    end
  end
end
