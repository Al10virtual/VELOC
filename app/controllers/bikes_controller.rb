class BikesController < ApplicationController

  def index
    @bikes = Bike.all
  end

  def show
    @bike = Bike.find(params[:id])
  end

  def new
    @bikes = Bike.new
  end

  def create
    @bike = Bike.new(bike_params)
    @bike.save
  end

  private

  def restaurant_params
    params.require(:bike).permit(:id)
  end
end
