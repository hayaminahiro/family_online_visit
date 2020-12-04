class RequestResident < ApplicationRecord
  belongs_to :user

  validates :req_name, presence: true, on: :create_request
  validates :req_phone, presence: true, on: :create_request
  validates :req_address, presence: true, on: :create_request

  enum req_approval: { "申請中": 0, "承認済": 1, "否認済": 2 }

  scope :applied, ->(facility) { where(facility_id: facility).where.not(req_approval: "申請中") }
  scope :active, ->(facility) { where(facility_id: facility).where(req_approval: "申請中") }

  def self.changer(facility, user)
    order(created_at: :desc).where(facility_id: facility).find_by(user_id: user)
  end
end
