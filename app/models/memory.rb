class Memory < ApplicationRecord
  belongs_to :resident
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :image0,  presence: true
  validates :title,   presence: true, length: {maximum: 20}
  validates :message, presence: true, length: {minimum: 10}
  validates :event_date, presence: true

  # モデル | ImageUploaderクラスとimageカラムを紐づける
  mount_uploader :image0, ImageUploader
  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
  mount_uploader :image4, ImageUploader
  mount_uploader :image5, ImageUploader
  mount_uploader :image6, ImageUploader
  mount_uploader :image7, ImageUploader

  # num = 0
  # while num < 8
  #   mount_uploader :"image#{num}", ImageUploader
  #   num += 1
  # end
end
