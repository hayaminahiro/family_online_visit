class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, unique: true, null: false
      t.string :password, null: false
      t.string :password_digest, null: false
      t.string :room_name
      t.boolean :admin, default: false
      t.boolean :floor_authority, default: false
      t.string :resident_name1
      t.string :resident_name2
      t.string :phone, unique: true
      t.string :address
      t.timestamps
    end
  end
end
