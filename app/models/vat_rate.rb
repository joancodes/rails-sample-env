# == Schema Information
#
# Table name: vat_rates
#
#  id         :integer          not null, primary key
#  rate       :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer          not null
#
# Indexes
#
#  index_vat_rates_on_item_id  (item_id)
#
# Foreign Keys
#
#  item_id  (item_id => items.id)
#
class VatRate < ApplicationRecord
  belongs_to :item
end
