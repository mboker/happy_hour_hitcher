class RideDriversController < ApplicationController
  before_action :set_ride_driver, only: [:show, :edit, :update, :destroy]

  # GET /ride_drivers
  # GET /ride_drivers.json
  def index
    @ride_drivers = RideDriver.all
  end

  # GET /ride_drivers/1
  # GET /ride_drivers/1.json
  def show
  end

  # GET /ride_drivers/new
  def new
    @ride_driver = RideDriver.new
  end

  # GET /ride_drivers/1/edit
  def edit
  end

  # POST /ride_drivers
  # POST /ride_drivers.json
  def create
    break_flag = false
    @user = current_user
    @ride = Ride.find(params[:ride_id])
    @ride_driver = @user.ride_drivers.build(:ride => @ride)

    if RidePassenger.exists?(:ride_id => @ride, :user_id => @user) 
	respond_to do |format|
		format.html {redirect_to @user, alert: 'You cannot be a driver on a ride that you have a passenger seat for!'}
	end
       break_flag = true
    end


    if RideDriver.exists?(:ride_id => @ride) and break_flag == false
	respond_to do |format|
		format.html {redirect_to @user, alert: 'Ride already has a driver!'}
	end
       break_flag = true
    end

    if break_flag == false
      respond_to do |format|
        if @ride_driver.save
          format.html { redirect_to @ride, notice: 'You are now the driver for this ride.' }
          format.json { render action: 'show', status: :created, location: @ride_driver }
        else
          format.html { render action: 'new' }
          format.json { render json: @ride_driver.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /ride_drivers/1
  # PATCH/PUT /ride_drivers/1.json
  def update
    respond_to do |format|
      if @ride_driver.update(ride_driver_params)
        format.html { redirect_to @ride_driver, notice: 'Ride driver was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ride_driver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ride_drivers/1
  # DELETE /ride_drivers/1.json
  def destroy
    @ride_driver.destroy
    respond_to do |format|
      format.html { redirect_to @root }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ride_driver
      @ride_driver = RideDriver.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ride_driver_params
      params.require(:trip_driver).permit(:user_id, :ride_id)
    end
end
