class AddOmniauthToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :provider, after: :reset_password_sent_at
      t.string :uid, after: :reset_password_sent_at
      t.string :meta, after: :reset_password_sent_at
    end
  end
end
