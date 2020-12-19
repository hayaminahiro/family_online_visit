class AddReservationColumnToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :reservation_user, :string
    add_column :reservations, :reservation_email, :string
    add_column :reservations, :reservation_residents, :string
  end
end
