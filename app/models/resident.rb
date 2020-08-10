class Resident < ApplicationRecord
  has_many :relatives, dependent: :destroy
  has_many :users, through: :relatives
end
