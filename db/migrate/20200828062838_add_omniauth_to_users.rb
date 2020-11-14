class AddOmniauthToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string, after: :reset_password_sent_at
    add_column :users, :uid, :string, after: :reset_password_sent_at
    add_column :users, :meta, :string, after: :reset_password_sent_at
  end
end
