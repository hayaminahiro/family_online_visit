require 'rails_helper'

RSpec.describe CalendarSetting, type: :model do
  let(:facility) { create(:facility) }

  describe "presence of facility_id" do
    # facility_idがあれば有効な状態であること
    it "is valid with a facility_id" do
      calendar_setting = CalendarSetting.new(facility_id: facility.id)
      expect(calendar_setting).to be_valid
    end

    # facility_idがなければ無効な状態であること
    it "is invalid without a facility_id" do
      calendar_setting = CalendarSetting.new(facility_id: nil)
      calendar_setting.valid?
      expect(calendar_setting.errors[:facility]).to include("を入力してください")
    end
  end
end
