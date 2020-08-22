class CreateResidents < ActiveRecord::Migration[5.2]
  def change
    create_table :residents do |t|
      t.integer :facility_id
      t.string :name, null: false
      t.integer :floor, null: false
      t.string :charge_worker
      t.timestamps
    end
  end
end
