class FacilityUser < ApplicationRecord
  # optional: trueは、外部キーのnilを許可
  belongs_to :user, optional: true
  belongs_to :facility, optional: true
end
