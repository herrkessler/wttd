class Participant < ActiveRecord::Base

  # property :id, Serial, :key => true

  belongs_to :event
  belongs_to :user
end