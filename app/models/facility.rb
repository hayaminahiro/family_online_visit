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
  # User:Facility = 多対多 ・・・関連付け 申請のために作成
  has_many :request_residents, dependent: :destroy
  has_many :users, through: :request_residents

  validates :facility_name, presence: true

  # cookieでログイン情報を保持
  def remember_me
    true
  end

end
