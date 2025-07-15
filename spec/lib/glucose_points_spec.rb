# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GlucosePoints do
  context 'when condition' do

    let(:points) { [
      [now, 150],
      [now, 160]
    ] }

    let(:now) { DateTime.now }

    subject(:glucose_points) {
      GlucosePoints.new(points)
    }
    it 'acts like an array' do
      expect(glucose_points.first).to eq [now, 150]
    end
  end
end
