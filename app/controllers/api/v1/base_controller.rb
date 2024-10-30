module Api
  module V1
    class BaseController < ActionController::API
      rescue_from StandardError, with: :server_error

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      

      private

      def not_found(exception)
        render json: { error: exception.message }, status: :not_found
      end

      def parameter_missing(exception)
        render json: { error: exception.message }, status: :unprocessable_entity
      end

      def record_invalid(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end

      def server_error(exception)
        render json: { error: "internal server error", details: exception.message }, status: :internal_server_error
      end
    end
  end
end
