require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:room) { create(:room) }

  describe 'validations' do
    # Room Nameがなければ無効な状態であること
    it "is invalid without a room_name" do
      room = Room.new(
        room_name: "",
        user_id: "1",
        facility_id: "1"
      )
      room.valid?
      expect(room.errors[:room_name]).to include("を入力してください")
    end
  end
end
