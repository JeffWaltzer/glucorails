require 'rails_helper'

RSpec.describe GraphController, type: :controller do
  describe "#show" do
    let(:expected_date) { DateTime.now }
    let(:expected_year) { expected_date.year }
    let(:expected_month) { expected_date.month }
    let(:expected_day) { expected_date.day }

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
        get :show, params: {
              "date[year]": expected_year,
              "date[month]": expected_month,
              "date[day]": expected_day,
            }

        # http://localhost:3000/graph?date%5Byear%5D=2025&date%5Bmonth%5D=3&date%5Bday%5D=28&commit=Save+changes

        expect(GlucoseMeasurement).to have_received(:points_for).with(date: expected_date)
      end
    end
  end
end
