class AddFacilityToReservations < ActiveRecord::Migration[5.2]
  def change
    add_reference :reservations, :facility, foreign_key: true
  end
end
