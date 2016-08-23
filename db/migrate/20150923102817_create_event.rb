class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.string :title
      t.text :description
      t.datetime :event_date
      t.json :user_status
 
      t.timestamps null: false

    end
  end
end
