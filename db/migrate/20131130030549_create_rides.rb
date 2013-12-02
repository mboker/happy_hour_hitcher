class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :event_id
      t.date :day
      t.time :time
      t.integer :seats

      t.timestamps
    end
  end
end
