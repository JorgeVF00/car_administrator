require "application_system_test_case"

class MaintenanceServicesTest < ApplicationSystemTestCase
  setup do
    @maintenance_service = maintenance_services(:one)
  end

  test "visiting the index" do
    visit maintenance_services_url
    assert_selector "h1", text: "Maintenance services"
  end

  test "should create maintenance service" do
    visit maintenance_services_url
    click_on "New maintenance service"

    fill_in "Car", with: @maintenance_service.car_id
    fill_in "Date", with: @maintenance_service.date
    fill_in "Description", with: @maintenance_service.description
    fill_in "Status", with: @maintenance_service.status
    click_on "Create Maintenance service"

    assert_text "Maintenance service was successfully created"
    click_on "Back"
  end

  test "should update Maintenance service" do
    visit maintenance_service_url(@maintenance_service)
    click_on "Edit this maintenance service", match: :first

    fill_in "Car", with: @maintenance_service.car_id
    fill_in "Date", with: @maintenance_service.date
    fill_in "Description", with: @maintenance_service.description
    fill_in "Status", with: @maintenance_service.status
    click_on "Update Maintenance service"

    assert_text "Maintenance service was successfully updated"
    click_on "Back"
  end

  test "should destroy Maintenance service" do
    visit maintenance_service_url(@maintenance_service)
    click_on "Destroy this maintenance service", match: :first

    assert_text "Maintenance service was successfully destroyed"
  end
end
