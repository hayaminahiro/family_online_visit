class CreateFacilityUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :facility_users do |t|
      t.references :user, foreign_key: true
      t.references :facility, foreign_key: true

      t.timestamps
    end
  end
end
