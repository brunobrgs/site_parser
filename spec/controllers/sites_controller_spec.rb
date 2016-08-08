require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  let(:valid_attributes) do
    { url: 'http://www.google.com' }
  end

  let(:invalid_attributes) do
    { url: 'www.google.com' }
  end

  describe "GET #index" do
    it "assigns all sites as @sites" do
      site = Site.create! valid_attributes
      get :index, format: :json, params: {}
      expect(assigns(:sites)).to eq([site])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Site" do
        expect {
          post :create, format: :json, params: valid_attributes
        }.to change(Site, :count).by(1)
      end

      it "assigns a newly created site as @site" do
        post :create, format: :json, params: valid_attributes
        expect(assigns(:site)).to be_a(Site)
        expect(assigns(:site)).to be_persisted
      end

      it "shows the created site" do
        post :create, format: :json, params: valid_attributes
        expect(response.body).to eq Site.last.to_json
      end

      it "returns status 201" do
        post :create, params: valid_attributes
        expect(response.status).to eq 201
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved site as @site" do
        post :create, params: invalid_attributes
        expect(assigns(:site)).to be_a_new(Site)
      end

      it "returns status 422" do
        post :create, params: invalid_attributes
        expect(response.status).to eq 422
      end
    end
  end
end
