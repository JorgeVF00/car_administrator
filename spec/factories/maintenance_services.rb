FactoryBot.define do
  factory :maintenance_service do
    car
    description { Faker::Vehicle.standard_specs.sample }
    status { %w[in_progress pending completed].sample }
    date { Faker::Date.backward(days: 30) }
  end
end