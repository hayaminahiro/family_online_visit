class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :relatives, dependent: :destroy
  has_many :residents, through: :relatives
  has_many :reservations, dependent: :destroy
end
