class Resident < ApplicationRecord
  belongs_to :facility
  has_many :relatives, dependent: :destroy
  has_many :users, through: :relatives
  has_many :memories, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :charge_worker, presence: true, length: { maximum: 20 }

  scope :enrolled, -> { where(enrolled: true) }
  scope :leave, -> { where(enrolled: false) }

  # search定義
  def self.search(search, facility)
    facility.residents.includes(:users) unless search
    facility.residents.includes(:users).where('name LIKE ?', "%#{search}%").order(:id)
  end
end
