require 'rails_helper'

RSpec.describe MaintenanceService, type: :model do
  # Associations
  it { should belong_to(:car) }

  # Validations
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:date) }

  it 'validates that date is not in the future' do
    service = build(:maintenance_service, date: Date.tomorrow)
    service.valid?
    expect(service.errors[:date]).to include("must be a past or present date")
  end

  # Scopes
  describe '.filter_by_status' do
    let!(:pending_service) { create(:maintenance_service, status: :pending) }
    let!(:completed_service) { create(:maintenance_service, status: :completed) }

    it 'returns services with the specified status' do
      expect(MaintenanceService.filter_by_status(:pending)).to include(pending_service)
      expect(MaintenanceService.filter_by_status(:pending)).not_to include(completed_service)
    end
  end

  describe '.filter_by_plate' do
    let!(:car) { create(:car, plate_number: 'ABC123') }
    let!(:service) { create(:maintenance_service, car: car) }
    let!(:other_car) { create(:car, plate_number: 'XYZ789') }
    let!(:other_service) { create(:maintenance_service, car: other_car) }

    it 'returns services matching the specified plate' do
      expect(MaintenanceService.filter_by_plate('ABC')).to include(service)
      expect(MaintenanceService.filter_by_plate('ABC')).not_to include(other_service)
    end
  end
end
