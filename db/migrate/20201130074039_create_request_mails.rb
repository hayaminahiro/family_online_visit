class CreateRequestMails < ActiveRecord::Migration[5.2]
  def change
    create_table :request_mails do |t|
      t.references :facility, foreign_key: true
      t.string :title
      t.text :message

      t.timestamps
    end
  end
end
