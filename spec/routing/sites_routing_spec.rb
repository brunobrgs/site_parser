require "rails_helper"

RSpec.describe SitesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/v1/sites").to route_to("sites#index", format: 'json')
    end

    it "routes to #create" do
      expect(:post => "/v1/sites").to route_to("sites#create", format: 'json')
    end
  end
end
