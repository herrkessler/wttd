class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|

      t.string :title
      t.text :description
      t.string :icon
 
      t.timestamps null: false

    end
  end
end
