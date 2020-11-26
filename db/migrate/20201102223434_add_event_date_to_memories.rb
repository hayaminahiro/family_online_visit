class AddEventDateToMemories < ActiveRecord::Migration[5.2]
  def change
    add_column :memories, :event_date, :date, after: :message
  end
end
