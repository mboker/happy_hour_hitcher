class HomeController < ApplicationController
  def index
    @users = User.all
    @rides = Ride.all
    @rides_with_open_seats = Ride.where("seats > ?", 0)
    #@rides_needing_drivers = Ride.where(
  end
end
