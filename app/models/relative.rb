class Relative < ApplicationRecord
  belongs_to :user
  belongs_to :resident

  #search定義
  def self.search(search, facility)
    return facility.residents.where('name LIKE ?', "") unless search

    facility.residents.where('name LIKE ?', "%#{search}%").order(:id)
  end
end
