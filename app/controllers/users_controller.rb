class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @ride_seats = RidePassenger.where(user_id: @user.id).select(:ride_id).distinct
    @ride_drives = RideDriver.where(user_id: @user.id).select(:ride_id).distinct

    @user_driving_rides = Ride.joins('INNER JOIN ride_drivers ON ride_drivers.ride_id = rides.id')
    @user_sitting_rides = Ride.joins('INNER JOIN ride_passengers ON ride_passengers.ride_id = rides.id')
  end

end
