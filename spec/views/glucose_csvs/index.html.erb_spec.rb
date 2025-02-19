require 'rails_helper'

RSpec.describe "glucose_csvs/index", type: :view do
  before(:each) do
    assign(:glucose_csvs, [
      GlucoseCsv.create!(
        csv: "MyText"
      ),
      GlucoseCsv.create!(
        csv: "MyText"
      )
    ])
  end

  it "renders a list of glucose_csvs" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
