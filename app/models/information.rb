class Information < ApplicationRecord
  belongs_to :facility

  validates :news, presence: true
  validates :title, presence: true

  enum status: { others: 0, head: 1 }

  # モデル | ImageUploaderクラスとimageカラムを紐づける
  mount_uploader :image, ImageUploader

  # 自分が登録している施設のお知らせであり、statusがothersであるものを取得する
  scope :mypage_informations, -> (id){ where(facility_id: id).where(status: "others") }
end
