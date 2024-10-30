FactoryBot.define do
  factory :car do
    plate_number { Faker::Vehicle.license_plate }
    model { Faker::Vehicle.make_and_model }
    year { Faker::Vehicle.year }
  end
end
