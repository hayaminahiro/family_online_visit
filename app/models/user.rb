class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[google line]

  # User:Facility = 多対多 ・・・関連付け
  has_many :facility_users, dependent: :destroy
  has_many :facilities, through: :facility_users
  accepts_nested_attributes_for :facility_users, allow_destroy: true

  has_many :relatives, dependent: :destroy
  has_many :residents, through: :relatives
  has_many :reservations, dependent: :destroy

  validates :name, presence: true  #施設側からの家族（user）の編集で空白でエラーが出なかったため追加

  # cookieでログイン情報を保持
  def remember_me
    true
  end

  protected
  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.create(name:     auth.info.name,
                         email: auth.info.email,
                         provider: auth.provider,
                         uid:      auth.uid,
                         token:    auth.credentials.token,
                         password: Devise.friendly_token[0, 20],
                         meta:     auth.to_yaml)
    end
    user
  end
end
