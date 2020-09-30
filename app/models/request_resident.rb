class RequestResident < ApplicationRecord
  belongs_to :user
  belongs_to :facility

  validates :req_name, presence: true
  validates :req_phone, presence: true
  validates :req_address, presence: true

  enum req_approval: { "申請中": 0, "登録済": 1, "拒否": 2 }
end
