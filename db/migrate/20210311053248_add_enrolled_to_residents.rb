class AddEnrolledToResidents < ActiveRecord::Migration[5.2]
  def change
    add_column :residents, :enrolled, :boolean, default: true, null: false, after: :charge_worker
  end
end
