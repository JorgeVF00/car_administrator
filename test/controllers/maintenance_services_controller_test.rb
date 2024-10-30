require "test_helper"

class MaintenanceServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @maintenance_service = maintenance_services(:one)
  end

  test "should get index" do
    get maintenance_services_url
    assert_response :success
  end

  test "should get new" do
    get new_maintenance_service_url
    assert_response :success
  end

  test "should create maintenance_service" do
    assert_difference("MaintenanceService.count") do
      post maintenance_services_url, params: { maintenance_service: { car_id: @maintenance_service.car_id, date: @maintenance_service.date, description: @maintenance_service.description, status: @maintenance_service.status } }
    end

    assert_redirected_to maintenance_service_url(MaintenanceService.last)
  end

  test "should show maintenance_service" do
    get maintenance_service_url(@maintenance_service)
    assert_response :success
  end

  test "should get edit" do
    get edit_maintenance_service_url(@maintenance_service)
    assert_response :success
  end

  test "should update maintenance_service" do
    patch maintenance_service_url(@maintenance_service), params: { maintenance_service: { car_id: @maintenance_service.car_id, date: @maintenance_service.date, description: @maintenance_service.description, status: @maintenance_service.status } }
    assert_redirected_to maintenance_service_url(@maintenance_service)
  end

  test "should destroy maintenance_service" do
    assert_difference("MaintenanceService.count", -1) do
      delete maintenance_service_url(@maintenance_service)
    end

    assert_redirected_to maintenance_services_url
  end
end
