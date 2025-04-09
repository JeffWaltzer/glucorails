# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SvgBuilder do
  subject(:svg_builder) {
    described_class.new(
    [
      [DateTime.parse("02-14-2025 03:56 PM"), 308],
      [DateTime.parse("02-14-2025 04:01 PM"), 308],
      [DateTime.parse("02-14-2025 04:06 PM"), 299],
      [DateTime.parse("02-14-2025 04:11 PM"), 295],
      [DateTime.parse("02-14-2025 04:16 PM"), 308],
      [DateTime.parse("02-14-2025 04:21 PM"), 302],
      [DateTime.parse("02-14-2025 04:26 PM"), 300],
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

  it 'has an svg width' do
    expect(svg['width'].value).to eq "640"
  end

  it 'has an svg height'

  it 'has correct viewBox coordinates scaled to data'

  it 'has a polyLine with correct coordinates'


end
