class RentalsController < ApplicationController
  def new
    @rental = Rental.new
    @bike = Bike.find(params[:bike_id])
  end

  # We register the reservation with the calculation of the price
  def create
    @rental = Rental.new(rental_params)
    @bike = Bike.find(params[:bike_id])
    @rental.bike = @bike
    @rental.user = current_user
    delay = (@rental.end_date.mjd - @rental.start_date.mjd).to_i
    if delay >= 7
      @rental.total_price = @bike.price_per_week * (delay/7)
    else
      @rental.total_price = @bike.price_per_day * delay
    end
    if @rental.save
      redirect_to dashboards_path + '#mesreservations'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    @rental = Rental.find(params[:id])
    @rental.status = "accepted"
    if @rental.save
      redirect_to dashboards_path, notice: "La demande de location a été validée."
    else
      redirect_to dashboards_path, notice: "Une erreur est survenue"
    end
  end

  def deny
    @rental = Rental.find(params[:id])
    @rental.status = "denied"
    if @rental.save
      redirect_to dashboards_path, notice: "La demande de location a été refusée."
    else
      redirect_to dashboards_path, notice: "Une erreur est survenue"
    end
  end

  private

  # Strong params
  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :bike_id, :user_id, :status)
  end
end
