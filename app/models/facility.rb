class Facility < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :informations, dependent: :destroy
  has_many :residents, dependent: :destroy
  # User:Facility = 多対多 ・・・関連付け
  has_many :facility_users, dependent: :destroy
  has_many :users, through: :facility_users

  VALID_EMAIL_REGEX =                 /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :facility_name, presence: true, length: {maximum: 20}
  validates :email,                   presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }
  validates :password,                presence: true, length: {minimum: 6, maximum: 128}
  validates :password_confirmation,   presence: true, length: {minimum: 6, maximum: 128}

  # cookieでログイン情報を保持
  def remember_me
    true
  end

  # モデル | ImageUploaderクラスとimageカラムを紐づける
  mount_uploader :image, ImageUploader
  mount_uploader :icon, ImageUploader

    #search定義
    def self.search(search)
      where.not(admin: true).order(:id) unless search
      where('facility_name LIKE ?', "%#{search}%").where.not(admin: true).order(:id)
    end
end
