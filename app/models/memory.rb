class Memory < ApplicationRecord
  belongs_to :resident
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :images,  presence: true
  validates :title,   presence: true, length: {maximum: 20}
  validates :message, presence: true, length: {minimum: 10}

  # 複数形
  mount_uploaders :images, ImageUploader
  serialize :images, JSON
end
