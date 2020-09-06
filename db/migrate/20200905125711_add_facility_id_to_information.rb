class AddFacilityIdToInformation < ActiveRecord::Migration[5.2]
  def change
    add_reference :information, :facility, foreign_key: true
  end
end
