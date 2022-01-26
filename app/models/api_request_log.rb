# == Schema Information
#
# Table name: api_request_logs
#
#  id           :integer          not null, primary key
#  action       :string           default(""), not null
#  controller   :string           default(""), not null
#  path         :string           default(""), not null
#  request_body :json             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#  user_id      :integer
#
# Indexes
#
#  index_api_request_logs_on_company_id  (company_id)
#  index_api_request_logs_on_created_at  (created_at)
#  index_api_request_logs_on_user_id     (user_id)
#
class ApiRequestLog < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :user, optional: true
end
