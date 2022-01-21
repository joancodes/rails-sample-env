# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer          not null
#
# Indexes
#
#  index_customers_on_company_id  (company_id)
#
class Customer < ApplicationRecord
  belongs_to :company
  has_many :surveys
end
