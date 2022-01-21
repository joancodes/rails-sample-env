# == Schema Information
#
# Table name: surveys
#
#  id          :integer          not null, primary key
#  note        :text             default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :integer
#  customer_id :integer
#  user_id     :integer
#
# Indexes
#
#  index_surveys_on_company_id   (company_id)
#  index_surveys_on_customer_id  (customer_id)
#  index_surveys_on_user_id      (user_id)
#
require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
