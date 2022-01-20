# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Company < ApplicationRecord
  has_many :users
  has_many :customers
  has_many :questions
end
