class AddIndexToApiRequestLog < ActiveRecord::Migration[5.2]
  def change
    add_index :api_request_logs, :created_at
  end
end
