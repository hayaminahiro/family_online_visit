class AddFacilityNameToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :facility_name, :string, after: :id
  end
end
