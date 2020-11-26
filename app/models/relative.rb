class Relative < ApplicationRecord
  belongs_to :user
  belongs_to :resident

  # search定義
  def self.search(search, facility)
    return facility.residents.where('name LIKE ?', "%#{search}%").order(:id) if search.present?

    facility.residents.where('name LIKE ?', "")
  end
end
