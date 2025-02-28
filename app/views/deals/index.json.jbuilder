json.array! @deals do |deal|
  json.extract! deal, :id, :item_id, :price, :quantity, :vat_rate_id
  json.total_excl_vat deal.total_excl_vat
  json.total_incl_vat deal.total_incl_vat
  json.url company_transaction_deal_url(@sales_transaction.company, @sales_transaction, deal, format: :json)
end
