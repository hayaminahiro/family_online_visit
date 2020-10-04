class RequestResident < ApplicationRecord
  belongs_to :user

  validates :req_name, presence: true, on: :create_request
  validates :req_phone, presence: true, on: :create_request
  validates :req_address, presence: true, on: :create_request

  enum req_approval: { "申請中": 0, "登録済": 1, "拒否": 2 }
end
