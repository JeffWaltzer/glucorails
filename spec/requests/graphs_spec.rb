require 'rails_helper'

RSpec.describe "Graphs", type: :request do
  describe "GET /show" do
    # fixtures :glucose_csvs

    it "renders SVG" do
      get "/graphs/1"
      expect(response.body).to include("<svg")
    end

    describe "SVG" do
      let(:xml) do
        get "/graphs/1"
        xml = Nokogiri::XML.parse(response.body) do |config|
          config.options = Nokogiri::XML::ParseOptions::STRICT |
                           Nokogiri::XML::ParseOptions::DTDLOAD |
                           Nokogiri::XML::ParseOptions::DTDVALID
        end
        xml.remove_namespaces!
        xml
      end

      let(:polyline) { xml.at_xpath('/svg/svg/polyline').attributes }

      it 'has a polyline d' do
        expect(polyline['points'].value).to eq "0,30800 300,30800 600,29900 900,29500 1200,30800 1500,30200 1800,30000"
      end

    end
  end
end
