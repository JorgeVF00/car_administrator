class CarSerializer < ActiveModel::Serializer
  attributes :id, :plate_number, :model, :year
  has_many :maintenance_services
end
