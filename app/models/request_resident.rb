class RequestResident < ApplicationRecord
  belongs_to :user

  validates :req_name, presence: true, on: :create_request
  validates :req_phone, presence: true, on: :create_request
  validates :req_address, presence: true, on: :create_request

  enum req_approval: { "申請中": 0, "承認済": 1, "否認済": 2 }

  scope :applied, ->(facility) { includes(:user).where(facility_id: facility).where.not(req_approval: "申請中")  }
  scope :active, ->(facility) { includes(user: :residents).where(facility_id: facility).where(req_approval: "申請中") }
  scope :search_columns, ->(search) do
    where('users.name LIKE ?', "%#{search}%").
      or(where('req_name LIKE ?', "%#{search}%")).
        or(where('req_phone LIKE ?', "%#{search}%")).
          or(where('req_address LIKE ?', "%#{search}%"))
  end

  def self.changer(facility, user)
    order(created_at: :desc).where(facility_id: facility).find_by(user_id: user)
  end

  # search定義
  def self.search(search, facility)
    return joins(:user).includes(:user).where(facility_id: facility).search_columns(search).order(updated_at: :desc) if search.present?

    includes(:user).where(facility_id: facility).order(updated_at: :desc)
  end
end
