class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.refferences :company, foreign_key: true
      t.string :name, default: "", null: false
      t.string :api_key, default: "", null: false
      t.string :api_secret, default: "", null: false
      t.timestamps
    end
  end
end
