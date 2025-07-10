# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SvgBuilder do
  def assert_x_tick_mark(index)
    expect(x_ticks[index]['x1']).to eq(((index ) * 100).to_s)
    expect(x_ticks[index]['x2']).to eq(((index ) * 100).to_s)
    expect(x_ticks[index]['y1']).to eq '1000'
    expect(x_ticks[index]['y2']).to eq '990'
  end

  def assert_y_tick_mark(index)
    expect(y_ticks[index]['x1']).to eq '0'
    expect(y_ticks[index]['x2']).to eq '10'
    expect(y_ticks[index]['y1']).to eq ((index)* 100).to_s
    expect(y_ticks[index]['y2']).to eq ((index)* 100).to_s
  end

  subject(:svg_builder) { described_class.new(data) }

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

    let(:y_tick_labels) {xml.css('.y-tick-label')}
    let(:y_tick_text) {y_tick_labels.map(&:text).map(&:strip)}

    let(:x_tick_date_labels) {xml.css('.x-tick-date-label')}
    let(:x_tick_time_labels) {xml.css('.x-tick-time-label')}
    let(:x_tick_date_text) {x_tick_date_labels.map(&:text).map(&:strip)}
    let(:x_tick_time_text) {x_tick_time_labels.map(&:text).map(&:strip)}

    describe "when there is no data" do
      let(:data) { [] }

      it "copes sanely" do
        expect(no_data_message).to eq("No data")
      end
    end

    describe "things which don't depend on the data" do
      let(:data) { [] }

      it 'has an svg width' do
        expect(svg['width'].value).to eq "100%"
      end

      it 'has an svg height' do
        expect(svg['height'].value).to eq "95%"
      end

      it 'has correct viewBox coordinates' do
        expect(svg['viewBox'].value).to eq "0 0 1000 1000"
      end
    end

    describe "with the default data" do
      let(:data) do
        [
          [ DateTime.parse("2025-02-14T03:56-500"), 308 ],
          [ DateTime.parse("2025-02-14T04:01-500"), 308 ],
          [ DateTime.parse("2025-02-14T04:06-500"), 299 ]
        ]
      end

      it 'has x-axis' do
        expect(x_line['x1'].value).to eq '0'
        expect(x_line['x2'].value).to eq '1000'
        expect(x_line['y1'].value).to eq '999'
        expect(x_line['y2'].value).to eq '999'
      end

      it 'has correct first y tick label' do
        expect(y_tick_text[0]).to eq "3"
        expect(y_tick_labels[0]['x']).to eq('12')
        expect(y_tick_labels[0]['y']).to eq('1005')
      end

      it 'has correct last y tick label' do
        expect(y_tick_text[10]).to eq "3"
        expect(y_tick_labels[10]['x']).to eq('12')
        expect(y_tick_labels[10]['y']).to eq('5')
      end

      it 'has correct first x tick date label' do
        expect(x_tick_date_text[0]).to eq "02/14"
        expect(x_tick_date_labels[0]['x']).to eq('-17')
        expect(x_tick_date_labels[0]['y']).to eq('965')
      end

      it 'has correct first x tick time label' do
        expect(x_tick_time_text[0]).to eq "3:56 am"
        expect(x_tick_time_labels[0]['x']).to eq('-17')
        expect(x_tick_time_labels[0]['y']).to eq('985')
      end

      it 'has correct last x tick date label' do
        expect(x_tick_date_text[10]).to eq "02/14"
        expect(x_tick_date_labels[10]['x']).to eq('983')
        expect(x_tick_date_labels[10]['y']).to eq('965')
      end

      it 'has correct last x tick time label' do
        expect(x_tick_time_text[10]).to eq "4:06 am"
        expect(x_tick_time_labels[10]['x']).to eq('983')
        expect(x_tick_time_labels[10]['y']).to eq('985')
      end

      it 'has y-axis' do
        expect(y_line['x1'].value).to eq '1'
        expect(y_line['x2'].value).to eq '1'
        expect(y_line['y1'].value).to eq '0'
        expect(y_line['y2'].value).to eq '1000'
      end

      it "has correct 1st x tick" do
        assert_x_tick_mark(0)
      end

      it "has correct 5th x tick" do
        assert_x_tick_mark(4)
      end

      it "has correct 8th x tick" do
        assert_x_tick_mark(7)
      end

      it "has correct 9th x tick" do
        assert_x_tick_mark(9)
      end

      it "has correct 10th x tick" do
        assert_x_tick_mark(10)
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

      it 'has a polyline with correct stroke coordinates' do
        expect(polyline['points'].value).to eq "0,0 300,0 600,9"
      end

      it 'has a polyline with correct stroke color' do
        expect(polyline['stroke'].value).to eq 'white'
      end

      it 'has a polyline with correct stroke width' do
        expect(polyline['stroke-width'].value).to eq '20px'
      end
    end

    describe "" do
    end
  end
end
