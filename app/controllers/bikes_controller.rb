class BikesController < ApplicationController

  def index
    @bikes = Bike.all
    @markers = @bikes.geocoded.map do |bike|
      {
        lat: bike.latitude,
        lng: bike.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {bike: bike}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @bike = Bike.find(params[:id])
  end

  def new
    @bike = Bike.new
  end

  def create
    @bike = Bike.new(bike_params)
    @bike.user = current_user
    if @bike.save!
      redirect_to bikes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bike_params
    params.require(:bike).permit(:bike_type, :wheel_size, :frame_material,
                                 :brand, :condition, :price_per_day,
                                 :price_per_week, :bike_model, :is_electric, :photo)
  end
end
