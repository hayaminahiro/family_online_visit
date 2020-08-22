class Facility < ApplicationRecord
  has_many :facility_users
  has_many :users, through: :facility_users
  has_many :residents
end
