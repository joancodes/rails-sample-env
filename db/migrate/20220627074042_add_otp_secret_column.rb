class AddOtpSecretColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :top_secret, :string, default: '', null: false
  end
end
