module Api
  module V1
    class MaintenanceServicesController < Api::V1::BaseController
      include MaintenanceServicesControllerConcern

      def index
        super

        render json: {
          maintenance_services: ActiveModelSerializers::SerializableResource.new(@maintenance_services, each_serializer: MaintenanceServiceSerializer),
          meta: {
            current_page: @maintenance_services.current_page,
            total_pages: @maintenance_services.total_pages
          }
        }
      end

      def show
        super
        render json: @maintenance_service
      end

      private

      def respond_to_create
        if @maintenance_service.save
          render json: @maintenance_service, status: :created
        else
          render json: @maintenance_service.errors, status: :unprocessable_entity
        end
      end

      def respond_to_update
        render json: @maintenance_service, status: :ok
      end

      def respond_to_update_error
        render json: @maintenance_service.errors, status: :unprocessable_entity
      end

      def respond_to_destroy
        head :no_content
      end
    end
  end
end
