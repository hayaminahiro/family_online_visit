class Facility < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :informations, dependent: :destroy
  has_many :residents, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :calendar_setting, dependent: :destroy
  # User:Facility = 多対多 ・・・関連付け
  has_many :facility_users, dependent: :destroy
  has_many :users, through: :facility_users

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :facility_name, presence: true, length: { maximum: 20 }
  validates :email,                   presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }

  # モデル | ImageUploaderクラスとimageカラムを紐づける
  mount_uploader :image, ImageUploader
  mount_uploader :icon, ImageUploader

  # cookieでログイン情報を保持
  def remember_me
    true
  end

  # search定義
  def self.search(search)
    where.not(admin: true).order(:id) unless search
    where('facility_name LIKE ?', "%#{search}%").where.not(admin: true).order(:id)
  end
end
