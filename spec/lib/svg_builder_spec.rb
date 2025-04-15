# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SvgBuilder do
  subject(:svg_builder) {
    described_class.new(
      [
        [ DateTime.parse("2025-02-14T03:56+07:00"), 308 ],
        [ DateTime.parse("2025-02-14T04:01+07:00"), 308 ],
        [ DateTime.parse("2025-02-14T04:06+07:00"), 299 ],
        [ DateTime.parse("2025-02-14T04:11+07:00"), 295 ],
        [ DateTime.parse("2025-02-14T04:16+07:00"), 308 ],
        [ DateTime.parse("2025-02-14T04:21+07:00"), 302 ],
        [ DateTime.parse("2025-02-14T04:26+07:00"), 300 ]
      ]
    )
  }

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
    expect(svg['viewBox'].value).to eq "0 0 100 100"
  end

  it 'has a path with correct stroke coordinates' do
    expect(path['d'].value).to eq "m127,301l58,-69l121,-25l96,-39l68,229"
  end

  it 'has a path with correct stroke color' do
    expect(path['stroke'].value).to eq "#000000"
  end

  it 'has a path with correct stroke width' do
    expect(path['stroke-width'].value).to eq "5"
  end
end
