class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :postal_code, :integer, after: :address
    add_column :users, :prefecture_name, :string, after: :postal_code
    add_column :users, :address_city, :string, after: :prefecture_name
    add_column :users, :address_street, :string, after: :address_city
  end
end
