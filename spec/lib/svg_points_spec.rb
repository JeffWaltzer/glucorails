RSpec.describe SvgPoints do
  subject(:points) { SvgPoints.new(raw_data) }

  let(:raw_data) do
    GlucosePoints.new(
      [
        [DateTime.parse("2025-02-14T03:56+07:00"), 308],
        [DateTime.parse("2025-02-14T04:01+07:00"), 308],
        [DateTime.parse("2025-02-14T04:06+07:00"), 299]
      ])
  end

  it "@min_x has the right value" do
    expected_value = raw_data.first.first
    expect(points.start_time).to eq(expected_value)
  end

  it "@data has the right value" do
    expected_value = GlucosePoints.new( [
      [DateTime.parse("2025-02-14T03:56+07:00"), 308],
      [DateTime.parse("2025-02-14T04:01+07:00"), 308],
      [DateTime.parse("2025-02-14T04:06+07:00"), 299]
    ])

    expect(points.instance_variable_get(:@data)).to eq(expected_value)
  end

  describe "empty?" do
    describe "when there is data" do
      it "returns false" do
        expect(points.empty?).to be false
      end
    end

    describe "when there is no data" do
      let(:raw_data) { GlucosePoints.new( []) }

      it "returns true" do
        expect(points.empty?).to be true
      end
    end
  end

  describe "#points" do
    it "generatest the correct path" do
      expect(subject.points).to eq("0,0 300,0 600,9")
    end
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

  it "viewbox returns the correct value" do
    expect(points.viewbox).to eq("0 0 600 9")
  end
end
