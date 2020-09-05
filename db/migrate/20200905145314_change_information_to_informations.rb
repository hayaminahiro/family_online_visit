class ChangeInformationToInformations < ActiveRecord::Migration[5.2]
  def change
    rename_table :information, :informations
  end
end
