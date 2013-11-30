require 'test_helper'

class RideDriversControllerTest < ActionController::TestCase
  setup do
    @ride_driver = ride_drivers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ride_drivers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ride_driver" do
    assert_difference('RideDriver.count') do
      post :create, ride_driver: { ride_id: @ride_driver.ride_id, user_id: @ride_driver.user_id }
    end

    assert_redirected_to ride_driver_path(assigns(:ride_driver))
  end

  test "should show ride_driver" do
    get :show, id: @ride_driver
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ride_driver
    assert_response :success
  end

  test "should update ride_driver" do
    patch :update, id: @ride_driver, ride_driver: { ride_id: @ride_driver.ride_id, user_id: @ride_driver.user_id }
    assert_redirected_to ride_driver_path(assigns(:ride_driver))
  end

  test "should destroy ride_driver" do
    assert_difference('RideDriver.count', -1) do
      delete :destroy, id: @ride_driver
    end

    assert_redirected_to ride_drivers_path
  end
end
