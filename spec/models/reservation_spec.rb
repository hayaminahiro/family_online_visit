require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user)        { create(:user) }
  let(:facility)    { create(:facility) }
  let(:reservation) { create(:reservation) }

  describe 'validations' do
    # これから全てののカラムが存在すれば有効な状態であること
    it "is valid with all reservation column" do
      reservation = Reservation.new(
        user_id: user.id,
        facility_id: facility.id,
        reservation_date: Time.zone.today,
        started_at: DateTime.now,
        reservation_user: "sample_reservation_user",
        reservation_email: "sample@email.com",
        reservation_residents: "sample_resident"
      )
      expect(reservation).to be_valid
    end

    # user_idがなければ無効な状態であること
    it "is invalid without a user_id" do
      reservation = Reservation.new(user_id: nil)
      reservation.valid?
      expect(reservation.errors[:user]).to include("を入力してください")
    end

    # facility_idがなければ無効な状態であること
    it "is invalid without a facility_id" do
      reservation = Reservation.new(facility_id: nil)
      reservation.valid?
      expect(reservation.errors[:facility]).to include("を入力してください")
    end

    # 予約日がなければ無効な状態であること
    it "is invalid without a reservation_date" do
      reservation.reservation_date = ''
      reservation.valid?
      expect(reservation.errors[:reservation_date]).to include("を入力してください")
    end

    # 予約開始時間がなければ無効な状態であること
    it "is invalid without a started_at" do
      reservation.started_at = ''
      reservation.valid?
      expect(reservation.errors[:started_at]).to include("を入力してください")
    end

    # 面会者(ご家族）がなければ無効な状態であること
    it "is invalid without a reservation_user" do
      reservation.reservation_user = ''
      reservation.valid?
      expect(reservation.errors[:reservation_user]).to include("を入力してください")
    end

    # 予約者のメールアドレスがなければ無効な状態であること
    it "is invalid without a reservation_email" do
      reservation.reservation_email = ''
      reservation.valid?
      expect(reservation.errors[:reservation_email]).to include("を入力してください")
    end

    # 面会したい利用者がなければ無効な状態であること
    it "is invalid without a reservation_residents" do
      reservation.reservation_residents = ''
      reservation.valid?
      expect(reservation.errors[:reservation_residents]).to include("を入力してください")
    end
  end
end
