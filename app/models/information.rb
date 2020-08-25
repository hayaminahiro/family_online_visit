class Information < ApplicationRecord
  validates :news, presence: true
  validates :title, presence: true, uniqueness: true

  enum status: { others: 0, head: 1 }
end
