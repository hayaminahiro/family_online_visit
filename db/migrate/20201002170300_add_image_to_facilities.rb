class AddImageToFacilities < ActiveRecord::Migration[5.2]
  def change
    add_column :facilities, :image, :string, after: :admin
  end
end
