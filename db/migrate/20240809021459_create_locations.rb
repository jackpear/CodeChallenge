class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.integer :loc_id
      t.string :name
      t.string :city

      t.timestamps
    end
  end
end
