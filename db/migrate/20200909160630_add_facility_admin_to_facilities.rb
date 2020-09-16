class AddFacilityAdminToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :facility_admin, :boolean, default: false
  end
end
