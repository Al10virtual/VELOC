class DashboardsController < ApplicationController
  def profile
    @bikes = current_user.bikes
    @rentals = current_user.rentals
    @user = current_user
    @pending_rentals = @rentals.select { |rental| rental.status == "pending" }
    @accepted_rentals = @rentals.select { |rental| rental.status == "accepted" }
    @denied_rentals = @rentals.select { |rental| rental.status == "denied" }
    @rentals_user = Rental.where(bike: @user.bikes, status: 'pending')
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
