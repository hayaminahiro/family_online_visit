class FacilityUser < ApplicationRecord
  # optional: trueは、外部キーのnilを許可
  belongs_to :user, optional: true
  belongs_to :facility, optional: true

  #search定義
  def self.search(search, all, user)
    return all.where(['facility_name LIKE ?', "%#{search}%"]).where.not(admin: true, id: user.facilities).order(:id) if search.present?

    all.where('facility_name LIKE ?', "").where.not(admin: true)
  end
end
