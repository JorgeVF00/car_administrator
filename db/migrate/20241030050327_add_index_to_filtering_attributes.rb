class AddIndexToFilteringAttributes < ActiveRecord::Migration[7.2]
  def change
    add_index :cars, :plate_number, unique: true
    add_index :maintenance_services, :status
  end
end
