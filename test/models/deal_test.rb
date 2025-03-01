# == Schema Information
#
# Table name: deals
#
#  id             :integer          not null, primary key
#  price          :decimal(, )
#  quantity       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  item_id        :integer          not null
#  transaction_id :integer          not null
#  vat_rate_id    :integer          not null
#
# Indexes
#
#  index_deals_on_item_id         (item_id)
#  index_deals_on_transaction_id  (transaction_id)
#  index_deals_on_vat_rate_id     (vat_rate_id)
#
# Foreign Keys
#
#  item_id         (item_id => items.id)
#  transaction_id  (transaction_id => transactions.id)
#  vat_rate_id     (vat_rate_id => vat_rates.id)
#
require "test_helper"

class DealTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
