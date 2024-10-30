class MaintenanceServiceSerializer < ActiveModel::Serializer
  attributes :id, :status, :description, :date
  belongs_to :car
end
