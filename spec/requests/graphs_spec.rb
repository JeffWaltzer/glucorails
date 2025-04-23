require 'rails_helper'

RSpec.describe "Graphs", type: :request do
  describe "GET /show" do
    fixtures :glucose_csvs

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

      let(:title) { xml.at_xpath('/svg/g/title') }
      let(:svg) { xml.at_xpath('/svg').attributes }
      let(:polyline) { xml.at_xpath('/svg/g/polyline').attributes }

      it 'has an svg width' do
        expect(svg['width'].value).to eq "100%"
      end

      it 'has an svg height' do
        expect(svg['height'].value).to eq "100%"
      end

      it 'has a polyline d' do
        expect(polyline['points'].value).to eq "0,98 300,190 600,150 660,200"
      end

      it 'has a polyline stroke' do
        expect(polyline['stroke'].value).to eq 'black'
      end

    end
  end
end
