require 'rails_helper'

RSpec.describe GraphController, type: :controller do
  describe "#show" do
    let(:expected_start_time) { DateTime.now }
    let(:expected_start_year) { expected_start_time.year }
    let(:expected_start_month) { expected_start_time.month }
    let(:expected_start_day) { expected_start_time.day }

    let(:expected_end_time) { DateTime.now }
    let(:expected_end_year) { expected_end_time.year }
    let(:expected_end_month) { expected_end_time.month }
    let(:expected_end_day) { expected_end_time.day }

    before do
      GlucoseMeasurement.create!(
        measured_at: expected_start_time,
        glucose: 100,
        )

      allow(GlucoseMeasurement).to receive(:points_for).and_call_original
    end

    describe "with no parameters" do
      it 'calls #points_for with date: nil' do
        get :show

        expect(GlucoseMeasurement).to have_received(:points_for).with(start_time: nil, end_time: nil)
      end
    end

    describe "with a start_time parameter" do
      it "calls points_for with the date" do
        get :show, params: {
          
          start_time: {
                year: expected_start_year,
                month: expected_start_month,
                day: expected_start_day,
              }
            }

        expect(GlucoseMeasurement).to have_received(:points_for).
          with(start_time: expected_start_time, end_time: nil)
      end
    end

    describe "with a end_time parameter" do
      it "calls points_for with the date" do
        get :show, params: {

          end_time: {
                year: expected_end_year,
                month: expected_end_month,
                day: expected_end_day,
              }
            }

        expect(GlucoseMeasurement).to have_received(:points_for).
          with(start_time: nil, end_time: expected_end_time)
      end
    end
  end
end
