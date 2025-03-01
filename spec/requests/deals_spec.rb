require 'rails_helper'

RSpec.describe DealsController, type: :controller do
  let(:company) { Company.create!(name: "Test Company") }
  let(:region) { company.regions.create(name: Faker::Address.city) }
  let(:customer) { company.customers.create!(name: Faker::Restaurant.name, region_id: region.id) }
  let(:user) { company.users.create(name: Faker::Name.name) }
  let(:transaction_attributes) {
    { transaction_date: Date.today, company_id: company.id, customer_id: customer.id, user_id: user.id }
  }
  let(:transaction) { Transaction.create! transaction_attributes }
  let(:item_attributes) {
    { name: "Item Name", company_id: company.id }
  }
  let(:item) { Item.create! item_attributes }
  let(:vat_rate_attributes) {
    { rate: 20, item_id: item.id}
  }
  let(:vat_rate) { VatRate.create! vat_rate_attributes }

  let(:valid_attributes) {
    { item_id: item.id, transaction_id: transaction.id, quantity: 1, price: 100, vat_rate_id: vat_rate.id }
  }

  let(:invalid_attributes) {
    { item_id: nil, transaction_id: nil, quantity: nil, price: nil, vat_rate_id: nil}
  }

  describe "GET #index" do
    it "returns a success response" do
      Deal.create! valid_attributes
      get :index, params: { company_id: company.id, transaction_id: transaction.id }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      deal = Deal.create! valid_attributes
      get :show, params: { company_id: company.id, transaction_id: transaction.id, id: deal.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Deal" do
        expect {
          post :create, params: { company_id: company.id, transaction_id: transaction.id, deal: valid_attributes }
        }.to change(Deal, :count).by(1)
      end

      it "redirects to the created deal" do
        post :create, params: { company_id: company.id, transaction_id: transaction.id, deal: valid_attributes }
        expect(response).to redirect_to(company_transaction_path(company, transaction))
      end
    end

    context "with invalid params" do
      it "does not create a new Deal" do
        expect {
          post :create, params: { company_id: company.id, transaction_id: transaction.id, deal: invalid_attributes }
        }.not_to change(Deal, :count)
      end

      it "renders the 'new' template" do
        post :create, params: { company_id: company.id, transaction_id: transaction.id, deal: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { quantity: 2 }
    }

    context "with valid params" do
      it "updates the requested deal" do
        deal = Deal.create! valid_attributes
        put :update, params: { company_id: company.id, transaction_id: transaction.id, id: deal.id, deal: new_attributes }
        deal.reload
        expect(deal.quantity).to eq(2)
      end

      it "redirects to the deal" do
        deal = Deal.create! valid_attributes
        put :update, params: { company_id: company.id, transaction_id: transaction.id, id: deal.id, deal: new_attributes }
        expect(response).to redirect_to(company_transaction_path(company, transaction))
      end
    end

    context "with invalid params" do
      it "renders the 'edit' template" do
        deal = Deal.create! valid_attributes
        put :update, params: { company_id: company.id, transaction_id: transaction.id, id: deal.id, deal: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested deal" do
      deal = Deal.create! valid_attributes
      expect {
        delete :destroy, params: { company_id: company.id, transaction_id: transaction.id, id: deal.id }
      }.to change(Deal, :count).by(-1)
    end

    it "redirects to the deals list" do
      deal = Deal.create! valid_attributes
      delete :destroy, params: { company_id: company.id, transaction_id: transaction.id, id: deal.id }
      expect(response).to redirect_to(company_transaction_path(company, transaction))
    end
  end
end
