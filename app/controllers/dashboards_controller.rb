class DashboardsController < ApplicationController
  def profile
    @bikes = current_user.bikes
    @rentals = current_user.rentals
    @user = current_user
    @pending_rentals = Rental.joins(:bike).where(bikes: { user_id: current_user.id }, status: 'pending')
  end


end
