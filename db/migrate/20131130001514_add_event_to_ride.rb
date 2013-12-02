class AddEventToRide < ActiveRecord::Migration
  def change
    add_column :rides, :event_id, :integer
  end
end
