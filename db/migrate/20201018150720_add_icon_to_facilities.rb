class AddIconToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :icon, :string, after: :image
  end
end
