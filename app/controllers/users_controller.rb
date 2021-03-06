class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @ride_seats = RidePassenger.where(user_id: @user.id).select(:ride_id).distinct
    @ride_drives = RideDriver.where(user_id: @user.id).select(:ride_id).distinct

    @user_sitting_rides = Ride.joins(:ride_passengers).where(ride_passengers: {user_id: @user})	
    @user_driving_rides = Ride.joins(:ride_drivers).where(ride_drivers: {user_id: @user})
  end

  def edit
  end

end
