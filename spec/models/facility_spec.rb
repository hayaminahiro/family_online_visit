require 'rails_helper'

RSpec.describe Facility, type: :model do
  let(:facility) { create(:facility) }

  describe 'validations' do
    # 名前、メールアドレス、パスワードがあれば有効な状態であること
    it "is valid with a name, email, and password" do
      expect(facility).to be_valid
    end

    # 名前がなければ無効な状態であること
    it "is invalid without a name" do
      facility.facility_name = ''
      facility.valid?
      expect(facility.errors[:facility_name]).to include("を入力してください")
    end

    # 名前が20文字以上であれば登録できないこと
    it "is invalid if the name is longer than 50 characters" do
      facility.facility_name = "あ" * 21
      facility.valid?
      expect(facility.errors[:facility_name]).to include("は20文字以内で入力してください")
    end

    # メールアドレスがなければ無効な状態であること
    it "is invalid without a email" do
      facility.email = ''
      facility.valid?
      expect(facility.errors[:email]).to include("が入力されていません。")
    end

    # メールアドレスが101文字以上であれば登録できないこと
    it "is invalid if the email is longer than 101 characters" do
      facility.email = "a" * 89 + "@example.com"
      facility.valid?
      expect(facility.errors[:email]).to include("は100文字以下に設定して下さい。")
    end

    # メールアドレスは規定の正規表現に従うこと
    # ドメインのないメールアドレスは無効なこと
    it "is invalid with no domain" do
      facility.email = "test"
      facility.valid?
      expect(facility.errors[:email]).to include("は有効でありません。")
    end

    # ドメインのあるメールアドレスは有効なこと
    it "is valid with a domain" do
      facility.email = "test@example.com"
      expect(facility).to be_valid
    end

    # 重複したメールアドレスなら無効な状態であること
    it "is invalid if email is duplicated" do
      Facility.create(
        facility_name:                   "Sumner",
        email:                  "tester@example.com",
        password:               "dottle-nouveau",
        password_confirmation:  "dottle-nouveau",
      )
      other_facility = Facility.new(
        facility_name:                   "Sumner2",
        email:                  "tester@example.com",
        password:               "dottle-nouveau",
        password_confirmation:  "dottle-nouveau",
      )
      other_facility.valid?
      expect(other_facility.errors[:email]).to include("は既に使用されています。")
    end

    # パスワードがなければ無効な状態であること
    it "is invalid without a password" do
      facility.password = ''
      facility.valid?
      expect(facility.errors[:password]).to include("が入力されていません。")
    end

    # パスワードが5文字以下である場合は登録できないこと
    it "is invalid if the password is shorter than 5 characters" do
      facility.password = "dottl"
      facility.valid?
      expect(facility.errors[:password]).to include("は6文字以上に設定して下さい。")
    end

    # パスワードが6文字以上であれば登録できること
    it "is valid if the password is longer than 6 characters" do
      facility.password = "dottle"
      facility.password_confirmation = "dottle"
      expect(facility).to be_valid
    end
  end
end
