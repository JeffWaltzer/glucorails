# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GlucosePoints do
  context 'when condition' do

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
end
