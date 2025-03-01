FactoryBot.define do
  factory :deal do
    price { 100 }
    quantity { 2 }
    association :transaction
    association :item
    association :vat_rate
  end
end
