class CreateInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :information do |t|
      t.string :title
      t.text :news
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
