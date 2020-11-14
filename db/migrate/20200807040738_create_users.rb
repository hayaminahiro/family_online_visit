class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, unique: true, null: false
      t.string :password
      t.string :room_name
      t.boolean :admin, default: false
      t.string :phone, unique: true
      t.string :address
      t.timestamps
    end
  end
end
