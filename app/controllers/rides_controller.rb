class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
	

  # GET /rides
  # GET /rides.json
  def index
    @rides = Ride.all
  end

  # GET /rides/1
  # GET /rides/1.json
  def show
    @events = Event.where('id = ?', @ride.event_id)
    @passengers = User.joins(:ride_passengers).where(ride_passengers: {ride_id: @ride})
    @drivers = User.joins(:ride_drivers).where(ride_drivers: {ride_id: @ride})
  end

  # GET /rides/new
  def new
    @ride = Ride.new
    if params[:event_id]
      @ride.event_id = params[:event_id]
    end
    @ride.save
    if params[:user_id]
      @ride_driver = RideDriver.new
      @ride_driver.ride_id = @ride.id
      @ride_driver.user_id = params[:user_id]
      @ride_driver.save
    end
  end

  # GET /rides/1/edit
  def edit
  end

  # POST /rides
  # POST /rides.json
  def create
    @ride = Ride.new(ride_params)

    respond_to do |format|
      if @ride.save
        format.html { redirect_to @ride, notice: 'Ride was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ride }
      else
        format.html { render action: 'new' }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rides/1
  # PATCH/PUT /rides/1.json
  def update
    respond_to do |format|
      if @ride.update(ride_params)
        format.html { redirect_to @ride, notice: 'Ride was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rides/1
  # DELETE /rides/1.json
  def destroy
    @ride.destroy
    respond_to do |format|
      format.html { redirect_to rides_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ride
      @ride = Ride.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ride_params
      params.require(:ride).permit(:event_id, :day, :time, :seats)
    end
end
