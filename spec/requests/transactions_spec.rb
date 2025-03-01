require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:company) { Company.create!(name: "Test Company") }
  let(:region) { company.regions.create(name: Faker::Address.city) }
  let(:customer) { company.customers.create!(name: Faker::Restaurant.name, region_id: region.id) }
  let(:user) { company.users.create(name: Faker::Name.name) }

  let(:valid_attributes) {
    { transaction_date: Date.today, company_id: company.id, customer_id: customer.id, user_id: user.id }
  }

  let(:invalid_attributes) {
    { transaction_date: nil, company_id: nil, customer_id: nil, user_id: nil }
  }

  describe "GET #index" do
    it "returns a success response" do
      Transaction.create! valid_attributes
      get :index, params: { company_id: company.id }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      transaction = Transaction.create! valid_attributes
      get :show, params: { company_id: company.id, id: transaction.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Transaction" do
        expect {
          post :create, params: { company_id: company.id, transaction: valid_attributes }
        }.to change(Transaction, :count).by(1)
      end

      it "redirects to the created transaction" do
        post :create, params: { company_id: company.id, transaction: valid_attributes }
        expect(response).to redirect_to(company_transaction_path(company, Transaction.last))
      end
    end

    context "with invalid params" do
      it "does not create a new Transaction" do
        expect {
          post :create, params: { company_id: company.id, transaction: invalid_attributes }
        }.not_to change(Transaction, :count)
      end

      it "renders the 'new' template" do
        post :create, params: { company_id: company.id, transaction: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { transaction_date: Date.today }
    }

    context "with valid params" do
      it "updates the requested transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, params: { company_id: company.id, id: transaction.to_param, transaction: new_attributes }
        transaction.reload
        expect(transaction.transaction_date).to eq(Date.today)
      end

      it "redirects to the transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, params: { company_id: company.id, id: transaction.to_param, transaction: new_attributes }
        expect(response).to redirect_to(company_transaction_path(company, Transaction.last))
      end
    end

    context "with invalid params" do
      it "renders the 'edit' template" do
        transaction = Transaction.create! valid_attributes
        put :update, params: { company_id: company.id, id: transaction.to_param, transaction: invalid_attributes }
        expect(response).to render_template("edit")
      end
    end
  end
end
