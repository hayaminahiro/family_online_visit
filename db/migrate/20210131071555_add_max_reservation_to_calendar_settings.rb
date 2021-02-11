class AddMaxReservationToCalendarSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :calendar_settings, :max_reservation, :integer
  end
end
