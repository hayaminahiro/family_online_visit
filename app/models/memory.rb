class Memory < ApplicationRecord
  belongs_to :resident
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  # validates :images,  presence: true
  validates :title,   presence: true, length: {maximum: 20}
  validates :message, presence: true, length: {minimum: 10}
  validates :event_date, presence: true

  # 複数形
  mount_uploaders :r_images, ImageUploader
  serialize :r_images, JSON
end
