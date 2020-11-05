class RequestResident < ApplicationRecord
  belongs_to :user

  validates :req_name, presence: true, on: :create_request
  validates :req_phone, presence: true, on: :create_request
  validates :req_address, presence: true, on: :create_request

  enum req_approval: { "申請中": 0, "承認済": 1, "否認": 2 }
end
