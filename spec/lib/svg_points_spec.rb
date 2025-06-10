RSpec.describe SvgPoints do
  subject do
    SvgPoints.new(
      [
        [ DateTime.parse("2025-02-14T03:56+07:00"), 308 ],
        [ DateTime.parse("2025-02-14T04:01+07:00"), 308 ],
        [ DateTime.parse("2025-02-14T04:06+07:00"), 299 ]
      ]
    )
  end

  describe "#points" do
    it "generatest the correct path" do
      expect(subject.points).to eq("0,30800 300,30800 600,29900")
    end
  end
end
