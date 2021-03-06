class RidePassengersController < ApplicationController
  before_action :set_ride_passenger, only: [:show, :edit, :update, :destroy]

  # GET /ride_passengers
  # GET /ride_passengers.json
  def index
    @ride_passengers = RidePassenger.all
  end

  # GET /ride_passengers/1
  # GET /ride_passengers/1.json
  def show
  end

  # GET /ride_passengers/new
  def new
    @ride_passenger = RidePassenger.new
  end

  # GET /ride_passengers/1/edit
  def edit
  end

  # POST /ride_passengers
  # POST /ride_passengers.json
  def create
    break_flag = false
    @user = current_user
    @ride = Ride.find(params[:ride_id])

	#VERIFYING THAT USER IS NOT ALREADY A DRIVER ON THIS RIDE
    if RideDriver.exists?(:ride_id => @ride, :user_id => @user) 
	respond_to do |format|
		format.html {redirect_to @user, alert: 'You cannot be a passenger on a ride that you are driving!'}
	end
       break_flag = true
    end

	#VERIFYING THAT THERE IS AN OPEN SEAT TO TAKE
    if @ride.seats == 0 and break_flag == false 
	respond_to do |format|
		format.html {redirect_to @user, alert: 'Ride is full!'}
	end
	break_flag = true #could not get break to work here, so used this instead
    end

    if break_flag == false	
      @ride_passenger = @user.ride_passengers.build(:ride => @ride)
    
      if RidePassenger.exists?(:user_id => @user.id, :ride_id => @ride.id)
	  respond_to do |format|
                  format.html { redirect_to @user, alert: 'You are already a passenger on this ride.' }
	  end
      else 
        respond_to do |format|
          if @ride_passenger.save
	    @ride.seats = @ride.seats - 1
	    @ride.save
            format.html { redirect_to @ride, notice: 'You are now a passenger on this ride.' }
            format.json { render action: 'show', status: :created, location: @ride_passenger }
          else
            format.html { render action: 'new' }
            format.json { render json: @ride_passenger.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end
  # PATCH/PUT /ride_passengers/1
  # PATCH/PUT /ride_passengers/1.json
  def update
    respond_to do |format|
      if @ride_passenger.update(ride_passenger_params)
        format.html { redirect_to @ride_passenger, notice: 'Ride passenger was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ride_passenger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ride_passengers/1
  # DELETE /ride_passengers/1.json
  def destroy
    @ride_passenger.destroy
    respond_to do |format|
      format.html { redirect_to @root }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ride_passenger
      @ride_passenger = RidePassenger.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ride_passenger_params
      params.require(:ride_passenger).permit(:user_id, :ride_id)
    end
end
