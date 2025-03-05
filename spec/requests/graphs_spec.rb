require 'rails_helper'

RSpec.describe "Graphs", type: :request do
  describe "GET /show" do
    fixtures :glucose_csvs

    it "renders SVG" do
      get "/graphs/1"
      expect(response.body).to include("<svg")
    end

    it 'does something. what?' do
      get "/graphs/1"

      expect(response.body).to (include("<line"))
    end
  end
end
