require 'rails_helper'

RSpec.describe RequestResident, type: :model do
  let(:user) { create(:user) }

  describe "presence of user_id" do
    # user_idがあれば有効な状態であること
    it "is valid with a user_id" do
      request_resident = RequestResident.new(user_id: user.id)
      expect(request_resident).to be_valid
    end

    # user_idがなければ無効な状態であること
    it "is invalid without a user_id" do
      request_resident = RequestResident.new(user_id: nil)
      request_resident.valid?
      expect(request_resident.errors[:user]).to include("を入力してください")
    end
  end
end
