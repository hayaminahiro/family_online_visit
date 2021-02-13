require 'rails_helper'

RSpec.describe FacilityUser, type: :model do
  let(:user) { create(:user) }
  let(:facility) { create(:facility) }

  # ⬇️⬇️optional: trueがあるので以下のテストは失敗する⬇️⬇️

  # describe "presence of user_id and facility_id" do
  #   # user_id、facility_idがあれば有効な状態であること
  #   it "is valid with a user_id" do
  #     facility_user = FacilityUser.new(user_id: user.id, facility_id: facility.id)
  #     expect(facility_user).to be_valid
  #   end

  #   # user_idがなければ無効な状態であること
  #   it "is invalid without a user_id" do
  #     facility_user = FacilityUser.new(user_id: nil, facility_id: facility.id)
  #     facility_user.valid?
  #     binding.pry
  #     expect(facility_user.errors[:user]).to include("を入力してください")
  #   end

  #   # facility_idがなければ無効な状態であること
  #   it "is invalid without a facility_id" do
  #     facility_user = FacilityUser.new(facility_id: nil, user_id: user.id)
  #     facility_user.valid?
  #     expect(facility_user.errors[:facility]).to include("を入力してください")
  #   end
  # end
end
