equire 'rails_helper'

RSpec.describe VatRatesController, type: :controller do
  let(:company) { Company.create!(name: "Test Company") }
  let(:item_attributes) {
    { name: "Item Name", description: "Item Description", company_id: company.id }
  }
  let(:item) { Item.create! item_attributes }
  let(:valid_attributes) {
    { rate: 20, item_id: item.id, active_from: Date.today, active_to: Date.today }
  }

  let(:invalid_attributes) {
    { rate: nil, item_id: nil, active_from: nil, active_to: nil }
  }

  describe "GET #index" do
    it "returns a success response" do
      VatRate.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      vat_rate = VatRate.create! valid_attributes
      get :show, params: { id: vat_rate.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new VatRate" do
        expect {
          post :create, params: { vat_rate: valid_attributes }
        }.to change(VatRate, :count).by(1)
      end

      it "redirects to the created vat_rate" do
        post :create, params: { vat_rate: valid_attributes }
        expect(response).to redirect_to(VatRate.last)
      end
    end

    context "with invalid params" do
      it "does not create a new VatRate" do
        expect {
          post :create, params: { vat_rate: invalid_attributes }
        }.not_to change(VatRate, :count)
      end

      it "renders the 'new' template" do
        post :create, params: { vat_rate: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { rate: 25 }
    }

    context "with valid params" do
      it "updates the requested vat_rate" do
        vat_rate = VatRate.create! valid_attributes
        put :update, params: { id: vat_rate.to_param, vat_rate: new_attributes }
        vat_rate.reload
        expect(vat_rate.rate).to eq(25)
      end

      it "redirects to the vat_rate" do
        vat_rate = VatRate.create! valid_attributes
        put :update, params: { id: vat_rate.to_param, vat_rate: new_attributes }
        expect(response).to redirect_to(vat_rate)
      end
    end

    context "with invalid params" do
      it "renders the 'edit' template" do
        vat_rate = VatRate.create! valid_attributes
        put :update, params: { id: vat_rate.to_param, vat_rate: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested vat_rate" do
      vat_rate = VatRate.create! valid_attributes
      expect {
        delete :destroy, params: { id: vat_rate.to_param }
      }.to change(VatRate, :count).by(-1)
    end

    it "redirects to the vat_rates list" do
      vat_rate = VatRate.create! valid_attributes
      delete :destroy, params: { id: vat_rate.to_param }
      expect(response).to redirect_to(vat_rates_url)
    end
  end
end
