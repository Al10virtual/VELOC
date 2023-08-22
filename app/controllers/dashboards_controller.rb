class DashboardsController < ApplicationController
  def index
    @bikes = Bike.all
    @rentals = Rental.includes(:bike).all
  end
end
