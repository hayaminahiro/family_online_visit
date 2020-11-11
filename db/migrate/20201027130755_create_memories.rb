class CreateMemories < ActiveRecord::Migration[5.2]
  def change
    create_table :memories do |t|
      t.references :resident, foreign_key: true
      t.string :title
      t.string :message
      t.timestamps
    end
  end
end
