RSpec.describe SvgComponents::Points do
  subject(:svg_points) { SvgComponents::Points.new(glucose_points) }

  let(:glucose_points) { GlucosePoints.new(raw_data) }

  describe "when some data exceeds the healthy sugar limits" do
    let(:raw_data) do
      [
        [DateTime.parse("2025-02-14T03:51+07:00"), 50],
        [DateTime.parse("2025-02-14T03:56+07:00"), 308],
        [DateTime.parse("2025-02-14T04:01+07:00"), 308],
        [DateTime.parse("2025-02-14T04:06+07:00"), 299]
      ]
    end

    it "#polyline_points reneratest the correct path" do
      expect(svg_points.polyline_points).to eq("0,258 300,0 600,0 900,9")
    end

    it "#viewbox returns the correct value" do
      expect(svg_points.viewbox).to eq("0 0 900 258")
    end

    it "#viewbox_left returns the correct value" do
      expect(svg_points.viewbox_left).to eq(0)
    end

    it "#viewbox_top returns the correct value" do
      expect(svg_points.viewbox_top).to eq(0)
    end

    it "#viewbox_width returns the correct value" do
      expect(svg_points.viewbox_width).to eq(900)
    end

    it "#viewbox_height returns the correct value" do
      expect(svg_points.viewbox_height).to eq(258)
    end

    it "#graph_y_max returns the correct value" do
      expect(svg_points.graph_y_max).to eq(308)
    end

    it "#graph_y_min returns the correct value" do
      expect(svg_points.graph_y_min).to eq(50)
    end

    it "#invert returns the correct value" do
      expect(svg_points.invert(300)).to eq(8)
    end
  end

  describe "when the data does not exceed the healthy sugar limits" do
    let(:raw_data) do
      [
        [DateTime.parse("2025-02-14T03:56+07:00"), 100],
        [DateTime.parse("2025-02-14T04:01+07:00"), 101],
        [DateTime.parse("2025-02-14T04:06+07:00"), 102]
      ]
    end

    it "#polyline_points returns the correct path" do
      expect(svg_points.polyline_points).to eq("0,80 300,79 600,78")
    end

    it "#viewbox returns the correct value" do
      expect(svg_points.viewbox).to eq("0 0 600 110")
    end

    it "#viewbox_left returns the correct value" do
      expect(svg_points.viewbox_left).to eq(0)
    end

    it "#viewbox_top returns the correct value" do
      expect(svg_points.viewbox_top).to eq(0)
    end

    it "#viewbox_width returns the correct value" do
      expect(svg_points.viewbox_width).to eq(600)
    end

    it "#viewbox_height returns the correct value" do
      expect(svg_points.viewbox_height).to eq(110)
    end

    it "#invert returns the correct value" do
      expect(svg_points.invert(101)).to eq(79)
    end

    it "#graph_y_min returns the correct value" do
      expect(svg_points.graph_y_min).to eq(SvgBuilder::HEALTHY_SUGAR_LOW)
    end

    it "#graph_y_max returns the healthy sugar high value" do
      expect(svg_points.graph_y_max).to eq(SvgBuilder::HEALTHY_SUGAR_HIGH)
    end
  end
end
