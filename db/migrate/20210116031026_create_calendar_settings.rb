class CreateCalendarSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_settings do |t|
      t.string :regular_holiday
      t.date :cancellation_date
      t.string :cancellation_time
      t.references :facility, foreign_key: true
      t.timestamps
    end
  end
end
