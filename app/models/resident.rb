class Resident < ApplicationRecord
  belongs_to :facility

  has_many :relatives, dependent: :destroy
  has_many :users, through: :relatives

  validates :name, presence: true
  validates :charge_worker, presence: true
  # CSVインポート
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      resident = find_by(id: row["id"]) || new
      resident.attributes = row.to_hash.slice(*updatable_attributes)
      resident.save
    end
  end
  # CSVインポートで更新を許可するカラム
  def self.updatable_attributes
    ["name", "charge_worker", "facility_id"]
  end
end
