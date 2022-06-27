class CreateGcraSetting < ActiveRecord::Migration[5.2]
  def change
    create_table :gcra_settings do |t|
      t.references :company, foreign_key: true
      t.string :name, null: false, default: 'Limitatio in 10 mins'
      t.integer :bucket_size, null: false, default: 10, comment: 'cell の入る最大個数'
      t.integer :emission_interval, null: false, default: 2, comment: '1 cell の処理時間'
      t.datetime :tat, null: false, default: '2000-01-01 00:00:00', comment: '理論到達時間 Theory Arrival Time'
      t.timestamps
    end
  end
end
