class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.date :calendar_day
      t.date :reservation_time
      t.datetime :started_at
      t.datetime :finished_at
      t.timestamps
    end
  end
end
