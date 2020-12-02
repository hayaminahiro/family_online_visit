class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.references :user, foreign_key: true
      t.references :facility, foreign_key: true
      t.timestamps
    end
  end
end
