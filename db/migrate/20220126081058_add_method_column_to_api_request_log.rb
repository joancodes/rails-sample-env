class AddMethodColumnToApiRequestLog < ActiveRecord::Migration[5.2]
  def change
    add_column :api_request_logs, :method, :string, default: '', null: false
  end
end
