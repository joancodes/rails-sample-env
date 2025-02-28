# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  transaction_date :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  company_id       :integer          not null
#  customer_id      :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_transactions_on_company_id   (company_id)
#  index_transactions_on_customer_id  (customer_id)
#  index_transactions_on_user_id      (user_id)
#
# Foreign Keys
#
#  company_id   (company_id => companies.id)
#  customer_id  (customer_id => customers.id)
#  user_id      (user_id => users.id)
#
class Transaction < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :customer
  has_many :deals, foreign_key: 'transaction_id', dependent: :destroy

  validates :transaction_date, presence: true

  # Calculate total amount excluding VAT
  def total_excl_vat
    deals.sum(&:total_excl_vat)
  end

  # Calculate total amount including VAT
  def total_incl_vat
    deals.sum(&:total_incl_vat)
  end

  # Scope to filter by transaction date
  scope :by_transaction_date, ->(date) {
    where(transaction_date: date.beginning_of_day..date.end_of_day) if date.present?
  }

  # Scope to filter by customer
  scope :by_customer, ->(customer_id) {
    where(customer_id: customer_id) if customer_id.present?
  }

  # Scope to paginate results
  scope :paginate_results, ->(page) {
    page(page).per(10)
  }
end
