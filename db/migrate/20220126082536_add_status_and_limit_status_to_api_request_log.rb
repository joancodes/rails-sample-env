class AddStatusAndLimitStatusToApiRequestLog < ActiveRecord::Migration[5.2]
  def change
    change_table :api_request_logs do |t|
      t.integer :status, default: 0
      t.string :limit_status, null: false, default: 'none'
    end
  end
end
