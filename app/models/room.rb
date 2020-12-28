class Room < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  validates :room_name, presence: true, uniqueness: true
end
