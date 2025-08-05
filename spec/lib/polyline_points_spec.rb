RSpec.describe SvgComponents::PolylinePoints do
  subject(:points) { SvgComponents::PolylinePoints.new(glucose_points) }

  let(:raw_data) do
      [
        [DateTime.parse("2025-02-14T03:56+07:00"), 50],
        [DateTime.parse("2025-02-14T03:56+07:00"), 308],
        [DateTime.parse("2025-02-14T04:01+07:00"), 308],
        [DateTime.parse("2025-02-14T04:06+07:00"), 299]
      ]
  end

  let(:glucose_points) { GlucosePoints.new(raw_data) }

  describe "#polyline_points" do
    it "generatest the correct path" do
      expect(subject.polyline_points).to eq("0,258 0,0 300,0 600,9")
    end
  end

  describe "#viewbox" do
    it "returns the correct value" do
      expect(points.viewbox).to eq("0 0 600 258")
    end
  end

  describe "graph_y_max" do
    it "returns the correct value" do
      expect(subject.graph_y_max).to eq(308)
    end
  end

  describe "graph_y_min" do
    it "returns the correct value" do
      expect(subject.graph_y_min).to eq(50)
    end
  end

  describe "invert" do
    it "returns the correct value" do
      expect(subject.invert(300)).to eq(8)
    end
  end

  describe "when the data does not include the healthy sugar limits" do
    let(:raw_data) do
      [
        [DateTime.parse("2025-02-14T03:56+07:00"), 100],
        [DateTime.parse("2025-02-14T04:01+07:00"), 101],
        [DateTime.parse("2025-02-14T04:06+07:00"), 102]
      ]
    end

  describe "graph_y_min" do
    it "returns the correct value" do
      expect(subject.graph_y_min).to eq(SvgBuilder::HEALTHY_SUGAR_LOW)
    end
  end

    describe "graph_y_max" do
      it "returns the healthy sugar high value" do
        expect(subject.graph_y_max).to eq(SvgBuilder::HEALTHY_SUGAR_HIGH)
      end
    end
  end
end
