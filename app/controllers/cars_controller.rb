class CarsController < ApplicationController
  include CarsControllerConcern

  before_action :set_car, only: %i[ show edit update destroy ]

  def show
    super
    @maintenance_services = @car.maintenance_services.page(params[:page]).per(4)
  end

  def new
    @car = Car.new
  end

  def edit
  end

  private

    def respond_to_create
      if @car.save
        redirect_to @car, notice: "Car was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def respond_to_update
      redirect_to @car, notice: "Car was successfully updated."
    end

    def respond_to_update_error
      render :edit, status: :unprocessable_entity
    end

    def respond_to_destroy
      redirect_to cars_path, status: :see_other, notice: "Car was successfully destroyed."
    end
end
