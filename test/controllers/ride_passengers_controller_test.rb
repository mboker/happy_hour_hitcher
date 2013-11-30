require 'test_helper'

class RidePassengersControllerTest < ActionController::TestCase
  setup do
    @ride_passenger = ride_passengers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ride_passengers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ride_passenger" do
    assert_difference('RidePassenger.count') do
      post :create, ride_passenger: { ride_id: @ride_passenger.ride_id, user_id: @ride_passenger.user_id }
    end

    assert_redirected_to ride_passenger_path(assigns(:ride_passenger))
  end

  test "should show ride_passenger" do
    get :show, id: @ride_passenger
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ride_passenger
    assert_response :success
  end

  test "should update ride_passenger" do
    patch :update, id: @ride_passenger, ride_passenger: { ride_id: @ride_passenger.ride_id, user_id: @ride_passenger.user_id }
    assert_redirected_to ride_passenger_path(assigns(:ride_passenger))
  end

  test "should destroy ride_passenger" do
    assert_difference('RidePassenger.count', -1) do
      delete :destroy, id: @ride_passenger
    end

    assert_redirected_to ride_passengers_path
  end
end
