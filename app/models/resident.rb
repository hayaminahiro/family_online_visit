class Resident < ApplicationRecord
  has_many :relatives, dependent: :destroy
end
