require 'rails_helper'

RSpec.describe "csv_uploads/new", type: :view do
  before(:each) do
    assign(:glucose_csv, "junk")
  end

  it "renders new glucose_csv form" do
    render

    assert_select "form[action=?][method=?]", csv_upload_path, "post" do
      assert_select "input[type=file]"
    end
  end
end
