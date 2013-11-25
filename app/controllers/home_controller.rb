class HomeController < ApplicationController
  def index
    @users = User.all
    @rides = Ride.all
  end
end
