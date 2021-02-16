class AddReadToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :read, :boolean, default: false
  end
end
