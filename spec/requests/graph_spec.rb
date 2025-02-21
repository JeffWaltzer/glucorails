require 'rails_helper'

RSpec.describe "Graphs", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/graph/show"
      expect(response).to have_http_status(:success)
    end
  end

end
