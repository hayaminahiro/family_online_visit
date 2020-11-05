class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :my_images do |t|
      t.references :memory, foreign_key: true
      t.string :r_image
      t.timestamps
    end
  end
end
