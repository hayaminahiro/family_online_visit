class CreateRequestResidents < ActiveRecord::Migration[5.2]
  def change
    create_table :request_residents do |t|
      t.references :user, foreign_key: true
      t.references :facility, foreign_key: true
      t.string :req_name
      t.string :req_phone
      t.string :req_address
      t.integer :req_approval, default: 0

      t.timestamps
    end
  end
end
