require 'rails_helper'

RSpec.describe "glucose_csvs/edit", type: :view do
  let(:glucose_csv) {
    GlucoseCsv.create!(
      csv: "MyText"
    )
  }

  before(:each) do
    assign(:glucose_csv, glucose_csv)
  end

  it "renders the edit glucose_csv form" do
    render

    assert_select "form[action=?][method=?]", glucose_csv_path(glucose_csv), "post" do

      assert_select "textarea[name=?]", "glucose_csv[csv]"
    end
  end
end
