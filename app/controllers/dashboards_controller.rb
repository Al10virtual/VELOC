class DashboardsController < ApplicationController
  def profile
    @bikes = current_user.bikes
    @rentals = current_user.rentals
    @user = current_user
  end
end
