RSpec.describe GlucoseMeasurement do

  it 'returns nothing if no data' do
    expect(GlucoseMeasurement.points_for(date: '2025-05-01')).to eq([])
  end

  describe 'with data' do
    before do
      GlucoseMeasurement.create!(measured_at: '2025-05-01', glucose: 100)
      GlucoseMeasurement.create!(measured_at: '2025-05-02', glucose: 101)
      GlucoseMeasurement.create!(measured_at: '2025-05-02', glucose: 102)
      GlucoseMeasurement.create!(measured_at: '2025-05-03', glucose: 103)
    end

    it "Returns data for date" do
      expect(GlucoseMeasurement.points_for(date: '2025-05-02'))
        .to eq(
              [
                [DateTime.parse('2025-05-02'), 101],
                [DateTime.parse('2025-05-02'), 102]
              ]
            )
    end

  end

end