class CreateMaintenanceServices < ActiveRecord::Migration[7.2]
  def change
    create_table :maintenance_services do |t|
      t.references :car, null: false, foreign_key: true
      t.string :description
      t.integer :status
      t.date :date

      t.timestamps
    end
  end
end
