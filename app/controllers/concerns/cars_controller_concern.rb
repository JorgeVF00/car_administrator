module CarsControllerConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_car, only: %i[ show update destroy ]
  end

  def index
    @cars = Car.page(params[:page]).per(10)
  end

  def show; end

  def create
    @car = Car.new(car_params)
    respond_to_create
  end

  def update
    if @car.update(car_params)
      respond_to_update
    else
      respond_to_update_error
    end
  end

  def destroy
    @car.destroy!
    respond_to_destroy
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:plate_number, :model, :year)
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
