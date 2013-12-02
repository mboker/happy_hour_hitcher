class AddLocationToRide < ActiveRecord::Migration
  def change
    add_column :rides, :ride_location, :integer
  end
end
