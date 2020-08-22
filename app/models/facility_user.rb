class FacilityUser < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :facility, optional: true
end
