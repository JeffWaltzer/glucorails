# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SvgBuilder do
  def has_x_tick_mark(index)
    expect(x_ticks[index]['x1']).to eq((index * 100).to_s)
    expect(x_ticks[index]['x2']).to eq((index * 100).to_s)
    expect(x_ticks[index]['y1']).to eq '959'
    expect(x_ticks[index]['y2']).to eq '949'
  end

  def has_y_tick_mark(index)
    expect(y_ticks[index]['x1']).to eq '0'
    expect(y_ticks[index]['x2']).to eq '10'
    expect(y_ticks[index]['y1']).to eq (index* 100).to_s
    expect(y_ticks[index]['y2']).to eq (index* 100).to_s
  end

  def has_correct_x_tick_date_label(index, expected_text:, expected_x_position:)
    expect(x_tick_date_text[index]).to eq(expected_text)
    expect(x_tick_date_labels[index]['x']).to eq(expected_x_position)
    expect(x_tick_date_labels[index]['y']).to eq('975')
  end

  def has_correct_x_tick_time_label(index, expected_text:, expected_x_position:)
    expect(x_tick_time_text[index]).to eq(expected_text)
    expect(x_tick_time_labels[index]['x']).to eq(expected_x_position)
    expect(x_tick_time_labels[index]['y']).to eq('995')
  end

  def has_correct_y_tick_label(index, expected_text:, expected_y_position:)
    expect(y_tick_text[index]).to eq expected_text
    expect(y_tick_labels[index]['x']).to eq('12')
    expect(y_tick_labels[index]['y']).to eq(expected_y_position)
  end

  subject(:svg_builder) { described_class.new(svg_points) }

  describe "#render" do
    let(:xml) do
      raw_svg = svg_builder.render

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

    let(:high_sugar_line) { xml.at_xpath('/svg/svg/line[@id="high-sugar"]')&.attributes }
    let(:high_sugar_line_value) { high_sugar_line['y1'].value }

    let(:low_sugar_line)  { xml.at_xpath('/svg/svg/line[@id="low-sugar"]')&.attributes }
    let(:low_sugar_line_value) { low_sugar_line['y1'].value }

    let(:no_data_message) { xml.at_xpath('/svg/text').text.strip }

    let(:x_line) { xml.css('#x-axis').first.attributes }
    let(:y_line) { xml.css('#y-axis').first.attributes }

    let(:x_ticks) { xml.css('.x-tick') }
    let(:y_ticks) { xml.css('.y-tick') }

    let(:y_tick_labels) { xml.css('.y-tick-label') }
    let(:y_tick_text) { y_tick_labels.map(&:text).map(&:strip) }

    let(:x_tick_date_labels) { xml.css('.x-tick-date-label') }
    let(:x_tick_time_labels) { xml.css('.x-tick-time-label') }
    let(:x_tick_date_text) { x_tick_date_labels.map(&:text).map(&:strip) }
    let(:x_tick_time_text) { x_tick_time_labels.map(&:text).map(&:strip) }


    describe "when there is no data" do
      let(:svg_points) { GlucosePoints.new([]) }

      it "copes sanely" do
        expect(no_data_message).to eq("No data")
      end
    end

    describe "things which don't depend on the data" do
      let(:svg_points) { GlucosePoints.new([]) }

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
      let(:svg_points) do
        GlucosePoints.new(
          [
            [ DateTime.parse("2025-02-14T03:56-500"), 308 ],
            [ DateTime.parse("2025-02-14T04:01-500"), 308 ],
            [ DateTime.parse("2025-02-14T04:06-500"), 299 ]
          ]
        )
      end

      it 'has x-axis' do
        expect(x_line['x1'].value).to eq '50'
        expect(x_line['x2'].value).to eq '1000'
        expect(x_line['y1'].value).to eq '949'
        expect(x_line['y2'].value).to eq '949'
      end

      it 'plot starts shifted over'

       it "has a low-sugar line" do
        expect(low_sugar_line_value).to eq("238")
      end

      it "has a high-sugar line" do
        expect(high_sugar_line_value).to eq("128")
      end

      it "has the correct y[0] tic label" do
        has_correct_y_tick_label 0, expected_text: "70", expected_y_position: "1005"
      end

      it "has the correct y[5] tic label" do
        has_correct_y_tick_label 5, expected_text: "189", expected_y_position: "505"
      end

      it 'has the correct y[10] tic label' do
        has_correct_y_tick_label 10, expected_text: "308", expected_y_position: "5"
      end

      it 'has the correct x[0] date label' do
        has_correct_x_tick_date_label 0, expected_text: "02/14", expected_x_position: "-17"
      end

      it 'has the correct x[0] tick time label' do
        has_correct_x_tick_time_label(0, expected_text: "3:56 am", expected_x_position: "-17")
      end

      it 'has the correct x[5] date label' do
        has_correct_x_tick_date_label 5, expected_text: "02/14", expected_x_position: "483"
      end

      it 'has the correct x[5] tick time label' do
        has_correct_x_tick_time_label(5, expected_text: "4:01 am", expected_x_position: "483")
      end

      it 'has the correct x[10] tick date label' do
        has_correct_x_tick_date_label 10, expected_text: "02/14", expected_x_position: "983"
      end

      it 'has the correct x[10] tick time label' do
        has_correct_x_tick_time_label(10, expected_text: "4:06 am", expected_x_position: "983")
      end

      it 'has y-axis' do
        expect(y_line['x1'].value).to eq '1'
        expect(y_line['x2'].value).to eq '1'
        expect(y_line['y1'].value).to eq '0'
        expect(y_line['y2'].value).to eq '1000'
      end

      it "has correct 1st x tick" do
        has_x_tick_mark(0)
      end

      it "has correct 5th x tick" do
        has_x_tick_mark(4)
      end

      it "has correct 8th x tick" do
        has_x_tick_mark(7)
      end

      it "has correct 9th x tick" do
        has_x_tick_mark(9)
      end

      it "has correct 10th x tick" do
        has_x_tick_mark(10)
      end

      it "has correct 1st y tick" do
        has_y_tick_mark(0)
      end
      it "has correct 5th y tick" do
        has_y_tick_mark(4)
      end
      it "has correct 10th y tick" do
        has_y_tick_mark(9)
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

    describe "with data that spans several days" do
      let(:svg_points) do
        GlucosePoints.new(
          [
            [ DateTime.parse("2025-02-14T03:56-500"), 60 ],
            [ DateTime.parse("2025-02-15T04:01-500"), 150 ],
            [ DateTime.parse("2025-02-16T04:06-500"), 200 ]
          ]
        )
      end

      it "has a low-sugar line" do
        expect(low_sugar_line).to be
      end

      it "has a high-sugar line" do
        expect(high_sugar_line).to be
      end

      it "has the correct y[0] tic label" do
        has_correct_y_tick_label 0, expected_text: "60", expected_y_position: "1005"
      end

      it "has the correct y[5] tic label" do
        has_correct_y_tick_label 5, expected_text: "130", expected_y_position: "505"
      end

      it 'has the correct y[10] tic label' do
        has_correct_y_tick_label 10, expected_text: "200", expected_y_position: "5"
      end

      it 'has the correct x[0] date label' do
        has_correct_x_tick_date_label 0, expected_text: "02/14", expected_x_position: "-17"
      end

      it 'has the correct x[0] tick time label' do
        has_correct_x_tick_time_label(0, expected_text: "3:56 am", expected_x_position: "-17")
      end

      it 'has the correct x[5] date label' do
        has_correct_x_tick_date_label 5, expected_text: "02/15", expected_x_position: "483"
      end

      it 'has the correct x[5] tick time label' do
        has_correct_x_tick_time_label(5, expected_text: "4:01 am", expected_x_position: "483")
      end

      it 'has the correct x[10] tick date label' do
        has_correct_x_tick_date_label 10, expected_text: "02/16", expected_x_position: "983"
      end

      it 'has the correct x[10] tick time label' do
        has_correct_x_tick_time_label(10, expected_text: "4:06 am", expected_x_position: "983")
      end
    end


    describe "with data that is entirely with health limits" do
      let(:svg_points) do
        GlucosePoints.new(
          [
            [ DateTime.parse("2025-02-14T03:56-500"),  75 ],
            [ DateTime.parse("2025-02-15T04:01-500"), 150 ],
            [ DateTime.parse("2025-02-16T04:06-500"), 160 ]
          ]
        )
      end

      it "has a low-sugar line" do
        expect(low_sugar_line).to be
      end

      it "has a high-sugar line" do
        expect(high_sugar_line).to be
      end

      it "has the correct y[0] tic label" do
        has_correct_y_tick_label 0, expected_text: "70", expected_y_position: "1005"
      end

      it "has the correct y[5] tic label" do
        has_correct_y_tick_label 5, expected_text: "125", expected_y_position: "505"
      end

      it 'has the correct y[10] tic label' do
        has_correct_y_tick_label 10, expected_text: "180", expected_y_position: "5"
      end
    end
  end
end
