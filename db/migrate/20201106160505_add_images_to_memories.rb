class AddImagesToMemories < ActiveRecord::Migration[5.2]
  def change
    change_table :memories, bulk: true do |t|
      t.string :image0, after: :event_date
      t.string :image1, after: :image0
      t.string :image2, after: :image1
      t.string :image3, after: :image2
      t.string :image4, after: :image3
      t.string :image5, after: :image4
      t.string :image6, after: :image5
      t.string :image7, after: :image6
    end
  end
end
