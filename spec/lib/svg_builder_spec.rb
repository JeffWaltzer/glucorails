# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SvgBuilder do
  subject(:svg_builder) { described_class.new(data) }

  let(:data) do
    [
      [ DateTime.parse("2025-02-14T03:56+07:00"), 308 ],
      [ DateTime.parse("2025-02-14T04:01+07:00"), 308 ],
      [ DateTime.parse("2025-02-14T04:06+07:00"), 299 ]
    ]
  end

  describe "#points" do
    it "generatest the correct path" do
      expect(subject.points).to eq("0,30800 300,30800 600,29900")
    end
  end

  describe "#render_from_csv" do
    let(:xml) do
      raw_svg = svg_builder.render_from_csv

      xml = Nokogiri::XML.parse(raw_svg) do |config|
        config.options = Nokogiri::XML::ParseOptions::STRICT |
                         Nokogiri::XML::ParseOptions::DTDLOAD |
                         Nokogiri::XML::ParseOptions::DTDVALID
      end
      xml.remove_namespaces!
      xml
    end

    let(:svg) { xml.at_xpath('/svg').attributes }
    let(:polyline) { xml.at_xpath('/svg/svg/polyline').attributes }
    let(:bounding_box) { xml.at_xpath('/svg/rect').attributes }
    let(:no_data_message) { xml.at_xpath('/svg/text').text.strip }

    describe "when there is no data" do
      let(:data) { [] }

      it "copes sanely" do
        expect(no_data_message).to eq("No data")
      end
    end

    it 'has an svg width' do
      expect(svg['width'].value).to eq "100%"
    end

    it 'has an svg height' do
      expect(svg['height'].value).to eq "100%"
    end

    it 'has correct viewBox coordinates' do
      expect(svg['viewBox'].value).to eq "0 0 1000 1000"
    end

    it 'has a nice bounding box' do
      expect(bounding_box['x'].value.to_i).to eq(0)
      expect(bounding_box['y'].value.to_i).to eq(0)
      expect(bounding_box['width'].value.to_i).to eq(1000)
      expect(bounding_box['height'].value.to_i).to eq(1000)
    end

    it 'has a polyline with correct stroke coordinates' do
      expect(polyline['points'].value).to eq "0,30800 300,30800 600,29900"
    end

    it 'has a polyline with correct stroke color' do
      expect(polyline['stroke'].value).to eq 'black'
    end

    it 'has a polyline with correct stroke width' do
      expect(polyline['stroke-width'].value).to eq '1em'
    end
  end
end
