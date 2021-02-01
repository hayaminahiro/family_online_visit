class RemoveReqPhoneFromRequestResidents < ActiveRecord::Migration[5.2]
  def change
    remove_column :request_residents, :req_phone, :string
    remove_column :request_residents, :req_address, :string
  end
end
