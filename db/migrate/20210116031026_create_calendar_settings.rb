class CreateCalendarSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_settings do |t|
      t.string :regular_holiday
      t.date :cancellation_date
      t.datetime :cancellation_time
      t.references :facility, foreign_key: true
      t.timestamps
    end
  end
end
