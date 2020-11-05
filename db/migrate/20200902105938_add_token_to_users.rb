class AddTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string, after: :reset_password_sent_at
  end
end
