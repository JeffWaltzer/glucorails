require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/glucose_csvs", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # GlucoseCsv. As you add validations to GlucoseCsv, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      GlucoseCsv.create! valid_attributes
      get glucose_csvs_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      glucose_csv = GlucoseCsv.create! valid_attributes
      get glucose_csv_url(glucose_csv)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_glucose_csv_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      glucose_csv = GlucoseCsv.create! valid_attributes
      get edit_glucose_csv_url(glucose_csv)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new GlucoseCsv" do
        expect {
          post glucose_csvs_url, params: { glucose_csv: valid_attributes }
        }.to change(GlucoseCsv, :count).by(1)
      end

      it "redirects to the created glucose_csv" do
        post glucose_csvs_url, params: { glucose_csv: valid_attributes }
        expect(response).to redirect_to(glucose_csv_url(GlucoseCsv.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new GlucoseCsv" do
        expect {
          post glucose_csvs_url, params: { glucose_csv: invalid_attributes }
        }.to change(GlucoseCsv, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post glucose_csvs_url, params: { glucose_csv: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested glucose_csv" do
        glucose_csv = GlucoseCsv.create! valid_attributes
        patch glucose_csv_url(glucose_csv), params: { glucose_csv: new_attributes }
        glucose_csv.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the glucose_csv" do
        glucose_csv = GlucoseCsv.create! valid_attributes
        patch glucose_csv_url(glucose_csv), params: { glucose_csv: new_attributes }
        glucose_csv.reload
        expect(response).to redirect_to(glucose_csv_url(glucose_csv))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        glucose_csv = GlucoseCsv.create! valid_attributes
        patch glucose_csv_url(glucose_csv), params: { glucose_csv: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested glucose_csv" do
      glucose_csv = GlucoseCsv.create! valid_attributes
      expect {
        delete glucose_csv_url(glucose_csv)
      }.to change(GlucoseCsv, :count).by(-1)
    end

    it "redirects to the glucose_csvs list" do
      glucose_csv = GlucoseCsv.create! valid_attributes
      delete glucose_csv_url(glucose_csv)
      expect(response).to redirect_to(glucose_csvs_url)
    end
  end
end
