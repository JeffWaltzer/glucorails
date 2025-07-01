RSpec.describe GlucoseMeasurement do
  it 'returns nothing if no data' do
    expect(GlucoseMeasurement.points_for(start_time: DateTime.new(2025, 5, 1, 0, 0, 0))).to eq([])
  end

  describe 'with data' do
    before do
      GlucoseMeasurement.create!(measured_at: '2025-05-01T03:56', glucose: 100)
      GlucoseMeasurement.create!(measured_at: '2025-05-02T03:56', glucose: 101)
      GlucoseMeasurement.create!(measured_at: '2025-05-03T03:56', glucose: 102)
      GlucoseMeasurement.create!(measured_at: '2025-05-04T03:56', glucose: 103)
    end

    it "returns data for start time only" do
      expect(GlucoseMeasurement.points_for(start_time: DateTime.new(2025, 5, 2, 0, 0, 0)))
        .to eq(
              [
                [DateTime.parse('2025-05-02T03:56'), 101],
                [DateTime.parse('2025-05-03T03:56'), 102],
                [DateTime.parse('2025-05-04T03:56'), 103]
              ]
            )
    end

    it "Returns data for end_time only" do
      expect(GlucoseMeasurement.points_for(end_time: DateTime.new(2025, 5, 2, 0, 0, 0)))
        .to eq(
              [
                [DateTime.parse('2025-05-01T03:56'), 100],
                [DateTime.parse('2025-05-02T03:56'), 101],
              ]
            )
    end

    it "Returns data for start_time and end_time" do
      expect(GlucoseMeasurement.points_for(
        start_time: DateTime.new(2025, 5, 2, 0, 0, 0),
        end_time: DateTime.new(2025, 5, 2, 0, 0, 0)
      ))
        .to eq([[DateTime.parse('2025-05-02T03:56'), 101]])
    end

    it 'tells us the first measurement' do
      expect(GlucoseMeasurement.earliest_date).to eq DateTime.parse('2025-05-01T03:56')
    end

    it 'tells us the first measurement' do
      expect(GlucoseMeasurement.latest_date).to eq DateTime.parse('2025-05-04T03:56')
    end

  end
end
