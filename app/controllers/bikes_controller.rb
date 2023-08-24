class BikesController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    if params[:type].present?
      @bikes = Bike.where(bike_type: params[:type])
    elsif params[:elec].present?
      @bikes = Bike.where(is_electric: true)
    else
      @bikes = Bike.all
    end
    @markers = @bikes.geocoded.map do |bike|
      {
        lat: bike.latitude,
        lng: bike.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { bike: bike }),
        marker_html: render_to_string(partial: "marker"),
        id: bike.id
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
    params.require(:bike).permit( :bike_type,
                                  :wheel_size,
                                  :frame_material,
                                  :brand,
                                  :model,
                                  :condition,
                                  :price_per_day,
                                  :price_per_week,
                                  :bike_model,
                                  :is_electric,
                                  :address,
                                  :photo)
  end
end
