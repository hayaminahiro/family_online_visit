class Tag < ApplicationRecord
  belongs_to :user
  has_many :tag_images, dependent: :destroy

  validates :title, presence: true
end
