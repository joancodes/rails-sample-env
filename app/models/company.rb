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
  has_many :users, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :surveys, dependent: :destroy
end
