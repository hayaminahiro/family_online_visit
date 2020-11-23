class Information < ApplicationRecord
  belongs_to :facility

  validates :news, presence: true
  validates :title, presence: true

  enum status: { others: 0, head: 1 }

  # モデル | ImageUploaderクラスとimageカラムを紐づける
  mount_uploader :image, ImageUploader

  # search定義
  def self.search(search, facility)
    facility.informations.where(status: "others").order(id: "DESC") unless search
    facility.informations.where(status: "others").where('title LIKE ?', "%#{search}%").order(id: "DESC")
  end
end
