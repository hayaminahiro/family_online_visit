class AddFacilityNameToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :facility_name, :string
  end
end
