require 'rails_helper'

RSpec.describe "glucose_csvs/show", type: :view do
  before(:each) do
    assign(:glucose_csv, GlucoseCsv.create!(
      csv: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end
end
