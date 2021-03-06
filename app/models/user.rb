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
  has_many :tags, dependent: :destroy
  has_many :tag_images, dependent: :destroy
  has_many :sns_credential, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :affiliations, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,                    presence: true, length: {maximum: 20}  #施設側からの家族（user）の編集で空白でエラーが出なかったため追加
  validates :email,                   presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }
  validates :postal_code,             presence: true, length: { is: 7 }, exclusion: { in: %w(該当する住所が存在しません。) }
  validates :prefecture_name,         presence: true, exclusion: { in: %w(該当する住所が存在しません。) }
  validates :address_city,            presence: true, exclusion: { in: %w(該当する住所が存在しません。) }
  validates :address_street,          presence: true, exclusion: { in: %w(該当する住所が存在しません。) }
  validates :phone,                   presence: true

  mount_uploader :image, ImageUploader
  mount_uploader :icon, ImageUploader

  validate :check_relative_invalid, on: :relative_update

  def check_relative_invalid
    errors.add(:resident_ids, "にチェックがありません") if resident_ids == []
  end

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

  #search定義
  def self.search(search, facility)
    facility.users.includes(:residents) unless search
    facility.users.includes(:residents).where('name LIKE ?', "%#{search}%").order(:id)
  end
end
