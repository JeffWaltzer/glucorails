# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GlucosePoints do
  context 'the old context' do
    let(:points) { [
      [now, 150],
      [now, 160]
    ] }

    let(:now) { DateTime.now }

    subject(:glucose_points) { GlucosePoints.new(points) }

    it 'acts like an array' do
      expect(glucose_points.first).to eq [now, 150]
    end

    it 'has equality' do
      expect(glucose_points == GlucosePoints.new(points)).to be_truthy
    end

    it 'has not equality' do
      expect(glucose_points == Object.new).to be_falsey
    end

    it '#each' do
      expect(glucose_points.each).to be_instance_of(Enumerator)
    end
  end

  context "specs moved up from SvgPoints" do
    subject(:points) { GlucosePoints.new(raw_data) }

    let(:raw_data) do
      [
        [DateTime.parse("2025-02-14T03:56+07:00"), 308],
        [DateTime.parse("2025-02-14T04:01+07:00"), 308],
        [DateTime.parse("2025-02-14T04:06+07:00"), 299]
      ]
    end

    it "@min_x has the right value" do
      expected_value = raw_data.first.first.to_i
      expect(points.start_time).to eq(expected_value)
    end

    it "@data has the right value" do
      expected_value = [
        [DateTime.parse("2025-02-14T03:56+07:00"), 308],
        [DateTime.parse("2025-02-14T04:01+07:00"), 308],
        [DateTime.parse("2025-02-14T04:06+07:00"), 299]
      ]

      expect(points.points).to eq(expected_value)
    end

    it "#x_min returns the correct value" do
      expect(points.x_min).to eq(0)
    end

    it "#y_min returns the correct value" do
      expect(points.y_min).to eq(299)
    end

    it "#x_max returns the correct value" do
      expect(points.x_max).to eq(600)
    end

    it "#y_max returns the correct value" do
      expect(points.y_max).to eq(308)
    end

    it "width returns the correct value" do
      expect(points.width).to eq(600)
    end

    it "height returns the correct value" do
      expect(points.height).to eq(9)
    end

    describe "empty?" do
      describe "when there is data" do
        it "returns false" do
          expect(points.empty?).to be false
        end
      end

      describe "when there is no data" do
        let(:raw_data) { [] }

        it "returns true" do
          expect(points.empty?).to be true
        end
      end
    end
  end
end
