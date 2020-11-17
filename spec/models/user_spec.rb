require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    # 名前、メールアドレス、パスワード、郵便番号、都道府県、住所、建物名があれば有効な状態であること
    it "is valid with a name, email, password, postal_code, prefecture_name, address_city and address_street" do
      expect(user).to be_valid
    end

    # 名前がなければ無効な状態であること
    it "is invalid without a name" do
      user.name = ''
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    # 名前が20文字以上であれば登録できないこと
    it "is invalid if the name is longer than 20 characters" do
      user.name = "あ" * 21
      user.valid?
      expect(user.errors[:name]).to include("は20文字以内で入力してください")
    end

    # メールアドレスがなければ無効な状態であること
    it "is invalid without a email" do
      user.email = ''
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end

    # メールアドレスが101文字以上であれば登録できないこと
    it "is invalid if the email is longer than 101 characters" do
      user.email = "a" * 89 + "@example.com"
      user.valid?
      expect(user.errors[:email]).to include("は100文字以下に設定して下さい。")
    end

    # メールアドレスは規定の正規表現に従うこと
    # ドメインのないメールアドレスは無効なこと
    it "is invalid with no domain" do
      user.email = "test"
      user.valid?
      expect(user.errors[:email]).to include("は有効でありません。")
    end

    # ドメインのあるメールアドレスは有効なこと
    it "is valid with a domain" do
      user.email = "test@example.com"
      expect(user).to be_valid
    end

    # 重複したメールアドレスなら無効な状態であること
    it "is invalid if email is duplicated" do
      User.create(
        name:                   "Sumner",
        email:                  "tester@example.com",
        phone:                  "08012345678",
        password:               "dottle-nouveau",
        password_confirmation:  "dottle-nouveau",
        postal_code:            "1234567",
        prefecture_name:        "Tokyo",
        address_city:           "tyuuou",
        address_street:         "nihonbashi"
      )
      other_user = User.new(
        name:                   "Sumner2",
        email:                  "tester@example.com",
        phone:                  "08012345678",
        password:               "dottle-nouveau",
        password_confirmation:  "dottle-nouveau",
        postal_code:            "1234567",
        prefecture_name:        "Tokyo",
        address_city:           "tyuuou",
        address_street:         "nihonbashi"
      )
      other_user.valid?
      expect(other_user.errors[:email]).to include("は既に使用されています。")
    end

    # パスワードがなければ無効な状態であること
    it "is invalid without a password" do
      user.password = ''
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end

    # パスワードが5文字以下である場合は登録できないこと
    it "is invalid if the password is shorter than 5 characters" do
      user.password = "dottl"
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end

    # パスワードが6文字以上であれば登録できること
    it "is valid if the password is longer than 6 characters" do
      user.password = "dottle"
      user.password_confirmation = "dottle"
      expect(user).to be_valid
    end

    # 郵便番号がなければ無効な状態であること
    it "is invalid without a postal_code" do
      user.postal_code = ''
      user.valid?
      expect(user.errors[:postal_code]).to include("を入力してください")
    end

    # 郵便番号が7文字以外であれば登録できないこと
    it "is invalid if postal_code is other than 7 characters" do
      user.postal_code = "123456"
      user.valid?
      expect(user.errors[:postal_code]).to include("は7文字で入力してください")
    end

    # 都道府県がなければ無効な状態であること
    it "is invalid without a prefecture_name" do
      user.prefecture_name = ''
      user.valid?
      expect(user.errors[:prefecture_name]).to include("を入力してください")
    end

    # 住所がなければ無効な状態であること
    it "is invalid without a address_city" do
      user.address_city = ''
      user.valid?
      expect(user.errors[:address_city]).to include("を入力してください")
    end

    # 建物名がなければ無効な状態であること
    it "is invalid without a address_street" do
      user.address_street  = ''
      user.valid?
      expect(user.errors[:address_street ]).to include("を入力してください")
    end

  #   # 市町村名が51文字以上であれば登録できないこと
  #   it "is invalid if the address_city is longer than 51 characters" do
  #     user.address_city = "あ" * 51
  #     user.valid?
  #     expect(user.errors[:address_city]).to include("は50文字以内で入力してください")
  #   end

  #   # 建物名が51文字以上であれば登録できないこと
  #   it "is invalid if the address_street is longer than 51 characters" do
  #     user.address_street = "あ" * 51
  #     user.valid?
  #     expect(user.errors[:address_street]).to include("は50文字以内で入力してください")
  #   end
  # end
  end
end
