class Inquiry < ApplicationRecord
  # belongs_to :facility
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,      presence: true
  validates :email,     presence: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }
  validates :message,   presence: true
end
