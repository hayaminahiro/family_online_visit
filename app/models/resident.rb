class Resident < ApplicationRecord
  has_many :relatives, dependent: :destroy
  has_many :users, through: :relatives

  validates :name, presence: true
  validates :floor, presence: true
  validates :charge_worker, presence: true
end
