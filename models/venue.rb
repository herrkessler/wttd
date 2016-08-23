require 'geocoder'


class Venue < ActiveRecord::Base

  extend Geocoder::Model::ActiveRecord

  geocoded_by :address
  before_save :geocode
 
  def address
    [self.street, self.zip, self.town, self.country].compact.join(', ')
  end

  has_and_belongs_to_many :users
  has_many :categories
  
end