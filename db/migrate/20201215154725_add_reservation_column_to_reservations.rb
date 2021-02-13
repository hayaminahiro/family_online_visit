class AddReservationColumnToReservations < ActiveRecord::Migration[5.2]
  def change
    change_table :reservations, bulk: true do |t|
      t.string :reservation_user
      t.string :reservation_email
      t.string :reservation_residents
    end
  end
end
