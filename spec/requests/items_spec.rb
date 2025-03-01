require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:company) { Company.create!(name: "Test Company") }
  let(:valid_attributes) {
    { name: "Item Name", company_id: company.id }
  }

  let(:invalid_attributes) {
    { name: nil, company_id: nil }
  }

  describe "GET #index" do
    it "returns a success response" do
      Item.create! valid_attributes
      get :index, params: { company_id: company.id }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      item = Item.create! valid_attributes
      get :show, params: { company_id: company.id, id: item.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, params: { company_id: company.id, item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it "redirects to the created item" do
        post :create, params: { company_id: company.id, item: valid_attributes }
        expect(response).to redirect_to(company_items_path(company))
      end
    end

    context "with invalid params" do
      it "does not create a new Item" do
        expect {
          post :create, params: { company_id: company.id, item: invalid_attributes }
        }.not_to change(Item, :count)
      end

      it "renders the 'new' template" do
        post :create, params: { company_id: company.id, item: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { name: "New Item Name" }
    }

    context "with valid params" do
      it "updates the requested item" do
        item = Item.create! valid_attributes
        put :update, params: { company_id: company.id, id: item.to_param, item: new_attributes }
        item.reload
        expect(item.name).to eq("New Item Name")
      end

      it "redirects to the item" do
        item = Item.create! valid_attributes
        put :update, params: { company_id: company.id, id: item.to_param, item: new_attributes }
        expect(response).to redirect_to(company_items_path(company))
      end
    end

    context "with invalid params" do
      it "renders the 'edit' template" do
        item = Item.create! valid_attributes
        put :update, params: { company_id: company.id, id: item.to_param, item: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, params: { company_id: company.id, id: item.to_param }
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      item = Item.create! valid_attributes
      delete :destroy, params: { company_id: company.id, id: item.to_param }
      expect(response).to redirect_to(company_items_path(company))
    end
  end
end
