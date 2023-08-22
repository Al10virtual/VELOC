class RentalsController < ApplicationController
  def new
    @rental = Rental.new
    @bike = Bike.find(params[:bike_id])
  end

  def create
    @rental = Rental.new(rental_params)
    @bike = Bike.find(params[:bike_id])
    @rental.bike = @bike
    @rental.user = current_user

    if @rental.save
      redirect_to root_path, notice: 'rental was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :bike_id, :user_id)
  end
end
