class Car < ApplicationRecord
  has_many :maintenance_services, dependent: :destroy

  validates :plate_number, presence: true, uniqueness: true
  validates :year, presence: true, inclusion: { in: 1990..Date.current.year }
end
