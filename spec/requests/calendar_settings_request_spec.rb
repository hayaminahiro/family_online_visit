require 'rails_helper'

RSpec.describe "CalendarSettings", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/calendar_settings/index"
      expect(response).to have_http_status(:success)
    end
  end
end
