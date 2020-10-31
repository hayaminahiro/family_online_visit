class Resident < ApplicationRecord
  belongs_to :facility
  has_many :relatives, dependent: :destroy
  has_many :users, through: :relatives

  validates :name, presence: true, length: { maximum: 20 }
  validates :charge_worker, presence: true, length: { maximum: 20 }
end
