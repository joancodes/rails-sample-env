# == Schema Information
#
# Table name: questions
#
#  id           :integer          not null, primary key
#  question     :string           default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  companies_id :integer
#
# Indexes
#
#  index_questions_on_companies_id  (companies_id)
#
class Question < ApplicationRecord
end
