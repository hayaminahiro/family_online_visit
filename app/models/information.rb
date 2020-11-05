class Information < ApplicationRecord
  belongs_to :facility

  validates :news, presence: true
  validates :title, presence: true

  enum status: { others: 0, head: 1 }

  # モデル | ImageUploaderクラスとimageカラムを紐づける
  mount_uploader :image, ImageUploader
end
