require 'rails_helper'

RSpec.describe Deal, type: :model do
  let(:company) { Company.create!(name: "Test Company") }
  let(:region) { company.regions.create(name: Faker::Address.city) }
  let(:customer) { company.customers.create!(name: Faker::Restaurant.name, region_id: region.id) }
  let(:user) { company.users.create(name: Faker::Name.name) }
  let(:item) { company.items.create!(name: Faker::Name.name) }
  let(:vat_rate) { item.vat_rates.create!(rate: Faker::Number.between(from: 1, to: 30)) }
  let(:sales_transaction) { Transaction.create!(company: company, user: user, customer: customer, transaction_date: Date.today) }
  let(:deal) { Deal.new(price: 100.0, quantity: 2, vat_rate: vat_rate, item: item, sales_transaction: sales_transaction) }

  describe 'associations' do
    it { is_expected.to belong_to(:sales_transaction).class_name('Transaction') }
    it { is_expected.to belong_to(:item) }
    it { is_expected.to belong_to(:vat_rate) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(1).with_message('must be at least 1') }
  end

  describe '#total_excl_vat' do
    it 'calculates the total price excluding VAT' do
      expect(deal.total_excl_vat).to eq(200.0) # 100 * 2
    end
  end

  describe '#total_incl_vat' do
    it 'calculates the total price including VAT' do
      expected_total = 200.0 * (1 + vat_rate.rate / 100.0) # 200 * 1.16
      expect(deal.total_incl_vat).to eq(expected_total)
    end
  end
end
