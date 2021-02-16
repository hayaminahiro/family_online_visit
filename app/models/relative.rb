class Relative < ApplicationRecord
  belongs_to :user
  belongs_to :resident

  # search定義
  def self.search(search, facility)
    return facility.residents.where('name LIKE ?', "%#{search}%").order(:id) if search.present?

    facility.residents
  end

  def self.reject_zero(resident_ids)
    resident_ids.map(&:to_i).reject(&:zero?).sort
  end

  def self.set_update_ids(update_ids)
    update_ids[:set_ids] = [] if update_ids[:set_ids].nil?
    new_resident_ids = update_ids[:resident_ids].concat(update_ids[:set_ids])
    update_ids.delete(:set_ids)
    self.reject_zero(new_resident_ids)
  end
end
