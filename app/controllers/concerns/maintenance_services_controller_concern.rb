module MaintenanceServicesControllerConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_maintenance_service, only: %i[ show update destroy ]
  end

  def index
    @maintenance_services = MaintenanceService.filter(filtering_params.slice(:status, :plate))
                                            .page(params[:page])
                                            .per(5)
  end

  def show
  end

  def create
    @maintenance_service = MaintenanceService.new(maintenance_service_params)
    respond_to_create
  end

  def update
    if @maintenance_service.update(maintenance_service_params)
      respond_to_update
    else
      respond_to_update_error
    end
  end

  def destroy
    @maintenance_service.destroy!
    respond_to_destroy
  end

  private

    def set_maintenance_service
      @maintenance_service = MaintenanceService.find(params[:id])
    end

    def maintenance_service_params
      params.require(:maintenance_service).permit(:car_id, :description, :status, :date)
    end

    def filtering_params
      params.permit(:status, :plate)
    end

    def respond_to_create
      raise NotImplementedError
    end

    def respond_to_update
      raise NotImplementedError
    end

    def respond_to_update_error
      raise NotImplementedError
    end

    def respond_to_destroy
      raise NotImplementedError
    end
end
