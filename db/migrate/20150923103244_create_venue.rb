class CreateVenue < ActiveRecord::Migration
  def change
    create_table :venues do |t|

      t.string :title
      t.text :synopsis
      t.text :description

      t.string :street
      t.string :zip
      t.string :town
      t.string :country

      t.float :latitude
      t.float :longitude

      t.string :url

      t.string :instagram

      t.text :checkin, array: true, default: []
      t.text :likes, array: true, default: []

      t.integer :curator_rating
      t.string :user_rating, array: true, default: []
      t.string :average_rating, array: true, default: []

      t.string :image_name
      t.string :gallery, array: true, default: ["site.png"]

      t.string :tags, array: true, default: []

      t.timestamps null: false

    end
  end
end
