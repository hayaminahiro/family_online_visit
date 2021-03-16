class AddEnrolledToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :enrolled, :boolean, default: true, null: false, after: :remember_created_at
  end
end
