class AddImagesToMemories < ActiveRecord::Migration[5.2]
  def change
    add_column :memories, :image0, :string, after: :event_date
    add_column :memories, :image1, :string, after: :image0
    add_column :memories, :image2, :string, after: :image1
    add_column :memories, :image3, :string, after: :image2
    add_column :memories, :image4, :string, after: :image3
    add_column :memories, :image5, :string, after: :image4
    add_column :memories, :image6, :string, after: :image5
    add_column :memories, :image7, :string, after: :image6
  end
end
