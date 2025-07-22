RSpec.describe SvgPoints do
  subject(:points) { SvgPoints.new(glucose_points) }

  let(:raw_data) do
      [
        [DateTime.parse("2025-02-14T03:56+07:00"), 308],
        [DateTime.parse("2025-02-14T04:01+07:00"), 308],
        [DateTime.parse("2025-02-14T04:06+07:00"), 299]
      ]
  end

  let(:glucose_points) { GlucosePoints.new(raw_data) }

  describe "#points" do
    it "generatest the correct path" do
      expect(subject.polyline_points).to eq("0,0 300,0 600,9")
    end
  end

  it "viewbox returns the correct value" do
    expect(points.viewbox).to eq("0 0 600 9")
  end
end
