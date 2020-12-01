class AddProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :text, after: :address_street
  end
end
