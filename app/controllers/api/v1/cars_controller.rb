module Api
  module V1
    class CarsController < Api::V1::BaseController
      include CarsControllerConcern

      def index
        super

        render json: {
          cars: ActiveModelSerializers::SerializableResource.new(@cars, each_serializer: CarSerializer),
          meta: {
            current_page: @cars.current_page,
            total_pages: @cars.total_pages
          }
        }
      end

      def show
        super

        render json: @car
      end

      private

      def respond_to_create
        if @car.save
          render json: @car, status: :created
        else
          render json: @car.errors, status: :unprocessable_entity
        end
      end

      def respond_to_update
        render json: @car, status: :ok
      end

      def respond_to_update_error
        render json: @car.errors, status: :unprocessable_entity
      end

      def respond_to_destroy
        head :no_content
      end
    end
  end
end
