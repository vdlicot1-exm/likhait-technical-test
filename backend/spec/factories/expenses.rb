FactoryBot.define do
  factory :expense do
    description { "Lunch" }
    amount { "9.99" }
    date { Date.today }
    association :category
  end
end
