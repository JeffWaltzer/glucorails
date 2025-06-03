# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SvgBuilder do

  def assert_x_tick_mark(index)
    expect(x_ticks[index]['x1']).to eq(((index + 1) * 100).to_s)
    expect(x_ticks[index]['x2']).to eq(((index + 1) * 100).to_s)
    expect(x_ticks[index]['y1']).to eq '500'
    expect(x_ticks[index]['y2']).to eq '490'
  end

  def assert_y_tick_mark(index)
    expect(y_ticks[index]['x1']).to eq '0'
    expect(y_ticks[index]['x2']).to eq '10'
    expect(y_ticks[index]['y1']).to eq ((index+1)* 50).to_s
    expect(y_ticks[index]['y2']).to eq ((index+1)* 50).to_s
  end

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
    let(:no_data_message) { xml.at_xpath('/svg/text').text.strip }

    let(:x_line) {xml.css('#x-axis').first.attributes}
    let(:y_line) {xml.css('#y-axis').first.attributes}

    let(:x_ticks) {xml.css('.x-tick')}
    let(:y_ticks) {xml.css('.y-tick')}

    describe "when there is no data" do
      let(:data) { [] }

      it "copes sanely" do
        expect(no_data_message).to eq("No data")
      end
    end

    it 'has x-axis' do
      expect(x_line['x1'].value).to eq '0'
      expect(x_line['x2'].value).to eq '1000'
      expect(x_line['y1'].value).to eq '500'
      expect(x_line['y2'].value).to eq '500'
    end

    it 'has y-axis' do
      expect(y_line['x1'].value).to eq '1'
      expect(y_line['x2'].value).to eq '1'
      expect(y_line['y1'].value).to eq '0'
      expect(y_line['y2'].value).to eq '500'
    end

    it "has correct 1st x tick" do
      assert_x_tick_mark(0)
    end
    it "has correct 5th x tick" do
      assert_x_tick_mark(4)
    end
    it "has correct 10th x tick" do
      assert_x_tick_mark(9)
    end

    it "has correct 1st y tick" do
      assert_y_tick_mark(0)
    end
    it "has correct 5th y tick" do
      assert_y_tick_mark(4)
    end
    it "has correct 10th y tick" do
      assert_y_tick_mark(9)
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
