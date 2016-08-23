class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :forename
      t.string :familyname

      t.string :username
      t.string :email
      t.string :password_digest

      t.boolean :admin, {default: false}

      t.string :avatar, {default: 'avatar.png'}
      t.string :gravatarURL

      t.string :zip

      t.text :checkin, array: true, default: []

      t.boolean :confirmed
 
      t.timestamps null: false
    end

    create_table :users_venues, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :venue, index: true
    end

  end
end
