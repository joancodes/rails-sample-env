class AddApiDailyRequestLimitToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :daily_request_limit_api, :integer, default: 100
  end
end
