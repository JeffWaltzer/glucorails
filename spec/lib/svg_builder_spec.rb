# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SvgBuilder do
  subject(:svg_builder) {
    described_class.new(
      [
        [ DateTime.parse("2025-02-14T03:56+07:00"), 308 ],
        [ DateTime.parse("2025-02-14T04:01+07:00"), 308 ],
        [ DateTime.parse("2025-02-14T04:06+07:00"), 299 ]
      ]
    )
  }

  describe "#path_d" do
    it "generatest the correct path" do
      expect(subject.path_d).to eq("m1739480160,308l1739480460,308l1739480760,299")
    end
  end

  describe "#render_from_csv" do
    let(:xml) do
      xml = Nokogiri::XML.parse(svg_builder.render_from_csv) do |config|
        config.options = Nokogiri::XML::ParseOptions::STRICT |
                         Nokogiri::XML::ParseOptions::DTDLOAD |
                         Nokogiri::XML::ParseOptions::DTDVALID
      end
      xml.remove_namespaces!
      xml
    end

    let(:svg) { xml.at_xpath('/svg').attributes }
    let(:path) { xml.at_xpath('/svg/g/path').attributes }

    it 'has an svg width' do
      expect(svg['width'].value).to eq "640"
    end

    it 'has an svg height' do
      expect(svg['height'].value).to eq "480"
    end

    it 'has correct viewBox coordinates scaled to data' do
      expect(svg['viewBox'].value).to eq "1739480160 299 1739480760 308"
    end

    it 'has a path with correct stroke coordinates' do
      expect(path['d'].value).to eq "m1739480160,308l1739480460,308l1739480760,299"
    end

    it 'has a path with correct stroke color' do
      expect(path['stroke'].value).to eq "#000000"
    end

    it 'has a path with correct stroke width' do
      expect(path['stroke-width'].value).to eq "5"
    end
  end
end
