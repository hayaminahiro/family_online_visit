class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories do |t|
      t.string :title
      t.string :message
      t.string :r_images
      t.references :resident, foreign_key: true
      t.timestamps
    end
  end
end
