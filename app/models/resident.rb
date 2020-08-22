class Resident < ApplicationRecord
  has_many :relatives, dependent: :destroy
  has_many :users, through: :relatives
  belongs_to :facility
end
