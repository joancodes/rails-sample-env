FactoryBot.define do
  factory :transaction do
    transaction_date { Time.zone.today }
    association :customer
    association :user
    association :company
  end
end
