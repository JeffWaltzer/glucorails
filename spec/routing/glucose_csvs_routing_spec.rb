require "rails_helper"

RSpec.describe GlucoseCsvsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/glucose_csvs").to route_to("glucose_csvs#index")
    end

    it "routes to #new" do
      expect(get: "/glucose_csvs/new").to route_to("glucose_csvs#new")
    end

    it "routes to #show" do
      expect(get: "/glucose_csvs/1").to route_to("glucose_csvs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/glucose_csvs/1/edit").to route_to("glucose_csvs#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/glucose_csvs").to route_to("glucose_csvs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/glucose_csvs/1").to route_to("glucose_csvs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/glucose_csvs/1").to route_to("glucose_csvs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/glucose_csvs/1").to route_to("glucose_csvs#destroy", id: "1")
    end
  end
end
