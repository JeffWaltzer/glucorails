require 'rails_helper'

RSpec.describe "Graphs", type: :request do
  describe "GET /show" do
    it "renders SVG" do
      get "/graph"
      expect(response.body).to include("<svg")
    end
  end
end
