class AddImagesToMemories < ActiveRecord::Migration[5.2]
  def change
    add_column :memories, :image0, :string
    add_column :memories, :image1, :string
    add_column :memories, :image2, :string
    add_column :memories, :image3, :string
    add_column :memories, :image4, :string
    add_column :memories, :image5, :string
    add_column :memories, :image6, :string
    add_column :memories, :image7, :string
  end
end
