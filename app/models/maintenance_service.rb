class MaintenanceService < ApplicationRecord
  include ActiveModel::Serializers::JSON
  belongs_to :car

  validates :description, presence: true
  validates :date, presence: true
  validate :date_not_in_future
  validates :status, presence: true

  enum :status, { :pending=>0, :in_progress=>1, :completed=>2 }

  scope :filter_by_status, ->(status) { where(status: status) if status.present? }
  scope :filter_by_plate, ->(plate) { 
    joins(:car).where('LOWER(cars.plate_number) LIKE ?', "%#{plate.downcase}%") if plate.present? 
  }

  def self.filter(params = {})
    params.to_h.slice(:status, :plate).reduce(all) do |scope, (key, value)|
      value.present? ? scope.public_send("filter_by_#{key}", value) : scope
    end
  end

  private

  def date_not_in_future
    if date.present? && date > Date.current
      errors.add(:date, 'must be a past or present date')
    end
  end
end
