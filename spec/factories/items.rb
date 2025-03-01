FactoryBot.define do
  factory :item do
    name { "Test Item" }
    association :company
  end
end
