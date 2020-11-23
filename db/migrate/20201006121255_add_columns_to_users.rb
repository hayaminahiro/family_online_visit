class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.integer :postal_code, after: :address
      t.string :prefecture_name, after: :postal_code
      t.string :address_city, after: :prefecture_name
      t.string :address_street, after: :address_city
    end
  end
end
