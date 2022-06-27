class CreateApiRequestLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :api_request_logs do |t|
      t.references :company, foreign_key: true, null: true
      t.references :user, foreign_key: true, null: true
      t.string :path, null: false, default: ''
      t.string :controller, null: false, default: ''
      t.string :action, null: false, default: ''
      t.json :request_body, null: false, default: {}
      t.timestamps
    end
  end
end
