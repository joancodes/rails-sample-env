require 'rails_helper'
require 'csv'

RSpec.describe Transaction, type: :model do
  let(:company) { Company.create!(name: "Test Company") }
  let(:region) { company.regions.create!(name: Faker::Address.city) }
  let(:customer) { company.customers.create!(name: Faker::Restaurant.name, region: region) }
  let(:user) { company.users.create!(name: Faker::Name.name) }
  let(:item) { company.items.create!(name: Faker::Commerce.product_name) }
  let(:vat_rate) { item.vat_rates.create!(rate: Faker::Number.between(from: 1, to: 30)) }

  let!(:sales_transaction) { Transaction.create!(company: company, user: user, customer: customer, transaction_date: Date.today) }
  
  # FIXED: Corrected foreign key for Deal
  let!(:deal) { Deal.create!(price: 100.0, quantity: 2, vat_rate: vat_rate, item: item, sales_transaction: sales_transaction) }

  describe "#total_excl_vat" do
    it "calculates the total price excluding VAT" do
      expect(sales_transaction.total_excl_vat).to eq(200.0) # 100 * 2
    end
  end

  describe "#total_incl_vat" do
    it "calculates the total price including VAT" do
      vat_multiplier = (1 + vat_rate.rate / 100.0)
      expected_total = 200.0 * vat_multiplier # 200 * (1 + VAT rate)
      expect(sales_transaction.total_incl_vat).to eq(expected_total)
    end
  end

  describe ".to_csv" do
    it "generates a CSV with correct headers and data" do
      csv_output = Transaction.to_csv
      csv = CSV.parse(csv_output, headers: true)

      expect(csv.count).to be > 0 # Ensure there is data
      expect(csv.headers).to eq(["ID", "Transaction Date", "Customer Name", "Total (Excl. VAT)", "Total (Incl. VAT)"])
      expect(csv[0]["Customer Name"]).to eq(customer.name)
      expect(csv[0]["Total (Excl. VAT)"].to_f).to eq(sales_transaction.total_excl_vat)
      expect(csv[0]["Total (Incl. VAT)"].to_f).to eq(sales_transaction.total_incl_vat)
    end
  end
end
