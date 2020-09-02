class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[google_oauth2 line]
=======
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[google line]

  # User:Facility = 多対多 ・・・関連付け
  has_many :facility_users, dependent: :destroy
  has_many :facilities, through: :facility_users
  accepts_nested_attributes_for :facility_users, allow_destroy: true

>>>>>>> e99865f6c630db8f1def578cb9d56bfe0c360166
  has_many :relatives, dependent: :destroy
  has_many :residents, through: :relatives
  has_many :reservations, dependent: :destroy

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
