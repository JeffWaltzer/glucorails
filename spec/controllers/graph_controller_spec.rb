require 'rails_helper'

RSpec.describe GraphController, type: :controller do
  describe "#show" do
    let(:expected_date) { DateTime.now }

    before do
      GlucoseMeasurement.create!(
        measured_at: expected_date,
        glucose: 100,
        )

      allow(GlucoseMeasurement).to receive(:points_for).and_call_original
    end

    describe "with no parameters" do
      it 'calls #points_for with date: nil' do
        get :show

        expect(GlucoseMeasurement).to have_received(:points_for).with(date: nil)
      end
    end

    describe "with a date parameter" do
      it "calls points_for with the date" do
        get :show, params: {date: expected_date}

        expect(GlucoseMeasurement).to have_received(:points_for).with(
          date: expected_date.to_s,
        )
      end
    end
  end
end
