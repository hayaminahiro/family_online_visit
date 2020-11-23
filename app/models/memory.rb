class Memory < ApplicationRecord
  belongs_to :resident

  validates :image0,  presence: true
  validates :title,   presence: true, length: { maximum: 20 }
  validates :message, presence: true
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
end
