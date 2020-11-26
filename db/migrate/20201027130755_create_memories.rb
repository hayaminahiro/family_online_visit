class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories do |t|
      t.references :resident, foreign_key: true
      t.string :title
      t.text :message
      t.integer :add_image_id
      t.timestamps
    end
  end
end
