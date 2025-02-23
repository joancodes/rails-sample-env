# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  question   :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#
# Indexes
#
#  index_questions_on_company_id  (company_id)
#
# Foreign Keys
#
#  company_id  (company_id => companies.id)
#
require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
