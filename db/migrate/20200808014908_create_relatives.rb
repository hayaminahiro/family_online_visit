class CreateRelatives < ActiveRecord::Migration[5.2]
  def change
    create_table :relatives do |t|
      t.references :user, foreign_key: true
      t.references :resident, foreign_key: true

      t.timestamps
    end
  end
end
