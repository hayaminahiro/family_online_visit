class CreateFacilityUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :facility_users do |t|
      t.references :user, foreign_key: true, null: false
      t.references :facility, foreign_key: true, null: false
      t.timestamps
    end
  end
end
