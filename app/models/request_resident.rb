class RequestResident < ApplicationRecord
  belongs_to :user

  validates :req_name, presence: true, on: :create_request

  enum req_approval: { request: 0,
                       approval: 1,
                       denial: 2 }

  scope :applied, ->(facility) { includes(:user).where(facility_id: facility).where.not(req_approval: "request") }
  scope :active, ->(facility) { includes(user: :residents).where(facility_id: facility).where(req_approval: "request").order(id: :desc) }
  scope :search_request_columns, (lambda do |search|
    where('users.name LIKE ?', "%#{search}%")
      .or(where('req_name LIKE ?', "%#{search}%"))
      .or(where('users.prefecture_name LIKE ?', "%#{search}%"))
      .or(where('users.address_city LIKE ?', "%#{search}%"))
      .or(where('users.address_street LIKE ?', "%#{search}%"))
  end)

  def self.changer(facility, user)
    order(created_at: :desc).where(facility_id: facility).find_by(user_id: user)
  end

  # search定義
  def self.search(search, facility)
    return joins(:user).includes(:user).where(facility_id: facility).search_request_columns(search).order(updated_at: :desc) if search.present?

    includes(:user).where(facility_id: facility).order(updated_at: :desc)
  end
end
