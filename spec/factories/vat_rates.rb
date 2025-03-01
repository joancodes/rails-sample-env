FactoryBot.define do
  factory :vat_rate do
    rate { 16 }
    association :item
  end
end
