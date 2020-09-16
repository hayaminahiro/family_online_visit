class AddFacilityIdToResidents < ActiveRecord::Migration[5.2]
  def change
    add_reference :residents, :facility, foreign_key: true
  end
end
