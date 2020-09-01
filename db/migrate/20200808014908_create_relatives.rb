class CreateRelatives < ActiveRecord::Migration[5.2]
  def change
    create_table :relatives do |t|
      t.references :user, foreign_key: true, null: false
      t.references :resident, foreign_key: true, null: false

      t.timestamps
    end
  end
end
