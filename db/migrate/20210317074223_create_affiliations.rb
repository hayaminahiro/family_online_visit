class CreateAffiliations < ActiveRecord::Migration[5.2]
  def change
    create_table :affiliations do |t|
      t.integer :facility_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
