RSpec.describe SvgBuilder do
  subject(:svg_builder) { described_class.new }

  it "exists" do
    expect(svg_builder).not_to be_nil
  end
end
