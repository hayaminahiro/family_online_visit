class AddImageToInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :information, :image, :string, after: :status
  end
end
