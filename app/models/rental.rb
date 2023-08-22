class Rental < ApplicationRecord
  belongs_to :bike
  belongs_to :user

  def show
    @rental = Rental.find(params[:id])
  end
end
