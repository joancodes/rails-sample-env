json.array! @transactions do |transaction|
  json.extract! transaction, :id, :transaction_date
  json.url company_transaction_url(@company, transaction, format: :json)
end
