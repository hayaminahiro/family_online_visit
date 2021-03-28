class AddUrlToInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :information, :url, :string, after: :news
  end
end
