RSpec.describe SvgPoints do
  subject(:points) { SvgPoints.new(raw_data) }

  let(:raw_data) do
      [
        [ DateTime.parse("2025-02-14T03:56+07:00"), 308 ],
        [ DateTime.parse("2025-02-14T04:01+07:00"), 308 ],
        [ DateTime.parse("2025-02-14T04:06+07:00"), 299 ]
      ]
  end    

  it "@min_x has the right value" do
    expected_value = raw_data.first.first.to_i
    expect(points.instance_variable_get(:@min_x)).to eq(expected_value)
  end

  it "@data has the right value" do
    expected_value = [
      [ 0, 30800 ],
      [ 300, 30800 ],
      [ 600, 29900 ]
    ]

    expect(points.instance_variable_get(:@data)).to eq(expected_value)
  end

  describe "empty?" do
    describe "when there is data" do
      it "returns false" do
        expect(points.empty?).to be false
      end
    end

    describe "when there is no data" do
      let(:raw_data) { [] }

      it "returns true" do
        expect(points.empty?).to be true
      end
    end
  end

  describe "#points" do
    it "generatest the correct path" do
      expect(subject.points).to eq("0,0 300,0 600,900")
    end
  end

  it "#x_min returns the correct value" do
    expect(points.x_min).to eq(0)
  end

  it "#y_min returns the correct value" do
    expect(points.y_min).to eq(29900)
  end

  it "#x_max returns the correct value" do
    expect(points.x_max).to eq(600)
  end

  it "#y_max returns the correct value" do
    expect(points.y_max).to eq(30800)
  end

  it "width returns the correct value" do
    expect(points.width).to eq(600)
  end

  it "height returns the correct value" do
    expect(points.height).to eq(900)
  end

  it "viewbox returns the correct value" do
    expect(points.viewbox).to eq("0 29900 600 900")
  end
end
