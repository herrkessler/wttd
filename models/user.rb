require 'bcrypt'
require 'gravatarify'

class User < ActiveRecord::Base

  include BCrypt
  include Gravatarify::Helper

  has_secure_password

  has_and_belongs_to_many :venues
  has_many :trips
  has_many :events

  before_save :gravatar

  def gravatar
    self.gravatarURL = gravatar_url(self, :size => 500, :default => 'mm')
  end

end