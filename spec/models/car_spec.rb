require 'rails_helper'

RSpec.describe Car, type: :model do
  # Associations
  it { should have_many(:maintenance_services).dependent(:destroy) }

  # Validations
  it { should validate_presence_of(:plate_number) }
  it { should validate_uniqueness_of(:plate_number) }
  it { should validate_presence_of(:year) }
  it { should validate_inclusion_of(:year).in_range(1990..Date.current.year) }
end
