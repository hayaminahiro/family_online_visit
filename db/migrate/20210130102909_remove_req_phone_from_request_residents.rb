class RemoveReqPhoneFromRequestResidents < ActiveRecord::Migration[5.2]
  def change
    change_table :request_residents, bulk: true do |t|
      t.remove :req_phone
      t.remove :req_address
    end
  end
end
