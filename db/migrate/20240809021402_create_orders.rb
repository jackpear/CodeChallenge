class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :jid
      t.integer :technician_id
      t.integer :location_id
      t.time :time
      t.integer :duration
      t.integer :price

      t.timestamps
    end
  end
end
