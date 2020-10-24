class Information < ApplicationRecord
  belongs_to :facility

  validates :news, presence: true
  validates :title, presence: true, uniqueness: true

  enum status: { others: 0, head: 1 }

  # 自分が登録している施設のお知らせであり、statusがothersであるものを取得する
  scope :mypage_informations, -> (id){ where(facility_id: id).where(status: "others") }
end
