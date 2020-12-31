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

  def self.image_columns(memories)
    image_columns = []
    memories.each do |m|
      image_columns << m.image0 if m.image0?
      image_columns << m.image1 if m.image1?
      image_columns << m.image2 if m.image2?
      image_columns << m.image3 if m.image3?
      image_columns << m.image4 if m.image4?
      image_columns << m.image5 if m.image5?
      image_columns << m.image6 if m.image6?
      image_columns << m.image7 if m.image7?
    end
    image_columns
  end
end
