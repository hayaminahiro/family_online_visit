class Image < ApplicationRecord
  belongs_to :memory, optional: true

  # モデル | ImageUploaderクラスとimageカラムを紐づける
  mount_uploader :image, ImageUploader
end
