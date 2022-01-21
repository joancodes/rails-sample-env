# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  answer      :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#  survey_id   :integer
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_survey_id    (survey_id)
#
class Answer < ApplicationRecord
  belongs_to :survey
  belongs_to :question, optional: true
end
