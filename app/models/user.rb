class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[google_oauth2 line]

  # User:Facility = 多対多 ・・・関連付け
  has_many :facility_users, dependent: :destroy
  has_many :facilities, through: :facility_users
  accepts_nested_attributes_for :facility_users, allow_destroy: true

  has_many :request_residents, dependent: :destroy
  has_many :relatives, dependent: :destroy
  has_many :residents, through: :relatives
  has_many :reservations, dependent: :destroy
  has_many :sns_credential, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,                    presence: true, length: { maximum: 20 }  # 施設側からの家族（user）の編集で空白でエラーが出なかったため追加
  validates :email,                   presence: true , uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, length: { minimum: 6, maximum: 128 }, on: :save_to_session_before_phone
  validates :password_confirmation,   presence: true, length: { minimum: 6, maximum: 128 }, on: :save_to_session_before_phone

  validates :postal_code,             presence: true, exclusion: { in: %w[該当する住所が存在しません。] }
  validates :prefecture_name,         presence: true, exclusion: { in: %w[該当する住所が存在しません。] }
  validates :address_city,            presence: true, exclusion: { in: %w[該当する住所が存在しません。] }
  validates :address_street,          presence: true, exclusion: { in: %w[該当する住所が存在しません。] }
  validates :phone,                   presence: true

  mount_uploader :image, ImageUploader
  validates :room_name,               presence: true, on: :room_word_update

  # cookieでログイン情報を保持
  def remember_me
    true
  end

  # パスワード入力なしでご家族情報編集可能にするため追加
  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first
    if user.present?
      sns = SnsCredential.create(
        uid: auth.uid,
        provider: auth.provider,
        user_id: user.id
      )
    else
      user = User.new(
        name: auth.info.name,
        email: auth.info.email
      )
      sns = SnsCredential.new(
        uid: auth.uid,
        provider: auth.provider
      )
    end
    return { user: user, sns: sns }
  end

  def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        name: auth.info.name,
        email: auth.info.email
      )
    end
    return { user: user }
    # ↑{ user: user }ここはreturnがなくていいかも
  end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user, sns: sns }
    # ↑{ user: user, sns: sns }ここはreturnがなくていいかも
  end

  # Naming/AccessorMethodName →"def values(omniauth)" or "def values"
  def set_values(omniauth)
    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']

    credentials = omniauth['credentials']
    info = omniauth['info']

    access_token = credentials['refresh_token']
    access_secret = credentials['secret']
    credentials = credentials.to_json
    name = info['name']
    # self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  # Naming/AccessorMethodName →"def values_by_raw_info(raw_info)" or "def values_by_raw_info"
  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end
end
