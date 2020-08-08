class User < ApplicationRecord
  has_many :relatives, dependent: :destroy
  has_many :reservations, dependent: :destroy
end
