class AddRefferenceToRegionFromCustomer < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :region, index: true, foreign_key: true, null: true
  end
end
