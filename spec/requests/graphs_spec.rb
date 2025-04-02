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
      let(:path) { xml.at_xpath('/svg/g/path').attributes }

      it 'has a title' do
        expect(title.text).to match "Layer 1"
      end

      it 'has an svg width' do
        expect(svg['width'].value).to eq "640"
      end

      it 'has an svg height' do
        expect(svg['height'].value).to eq "480"
      end

      it 'has a path d' do
        expect(path['d'].value).to eq "m127,301l58,-69l121,-25l96,-39l68,229"
      end

      it 'has a path stroke' do
        expect(path['stroke'].value).to eq '#000000'
      end

      it 'has a path stroke_width' do
        expect(path['stroke-width'].value).to eq "5"
      end
    end
  end
end
