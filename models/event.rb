class Event < ActiveRecord::Base

  belongs_to :user
  has_one :venue
  has_one :trip
  has_many :participants
end