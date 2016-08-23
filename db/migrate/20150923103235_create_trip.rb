class CreateTrip < ActiveRecord::Migration
  def change
    create_table :trips do |t|

      t.string :title
      t.text :description

      t.json :venue_order
 
      t.timestamps null: false
    end
  end
end
