class MaintenanceServicesController < ApplicationController
  include MaintenanceServicesControllerConcern

  before_action :set_maintenance_service, only: %i[ show edit update destroy ]

  def new
    @maintenance_service = MaintenanceService.new
  end

  def edit
  end

  private

    def respond_to_create
      if @maintenance_service.save
        redirect_to @maintenance_service, notice: "Maintenance service was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def respond_to_update
      redirect_to @maintenance_service, notice: "Maintenance service was successfully updated."
    end

    def respond_to_update_error
      render :edit, status: :unprocessable_entity
    end

    def respond_to_destroy
      redirect_to maintenance_services_path, status: :see_other, notice: "Maintenance service was successfully destroyed."
    end
end
