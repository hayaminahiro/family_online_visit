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

  def delete_image(column)
    case column
    when "image1"
      remove_image1!
    when "image2"
      remove_image2!
    when "image3"
      remove_image3!
    when "image4"
      remove_image4!
    when "image5"
      remove_image5!
    when "image6"
      remove_image6!
    else
      remove_image7!
    end
  end
end
