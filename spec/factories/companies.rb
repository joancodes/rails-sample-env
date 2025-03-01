FactoryBot.define do
  factory :company do
    name { "Test Company" }
    association :vat_rate
  end
end
