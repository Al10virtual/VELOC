class DashboardsController < ApplicationController
  def profile
    @bikes = current_user.bikes
    @rentals = current_user.rentals
    @user = current_user
    @pending_rentals = Rental.joins(:bike).where(bikes: { user_id: current_user.id }, status: 'pending')
    @accepted_rentals = Rental.joins(:bike).where(bikes: { user_id: current_user.id }, status: 'accepted')
    @denied_rentals = Rental.joins(:bike).where(bikes: { user_id: current_user.id }, status: 'denied')

  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboards_path, notice: 'Profil mis à jour avec succès.'
    else
      render :edit_profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

end
