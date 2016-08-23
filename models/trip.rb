class Trip < ActiveRecord::Base

  # property :id, Serial, :key => true
  # property :title, String, :required => true, :length => 128
  # property :description, Text, :lazy => [ :show ]

  # property :poi_sequence, Json

  # property :created_at, DateTime, :lazy => [ :show ]
  # property :update_at, DateTime, :lazy => [ :show ]

  has_many :venues
end