class WhatToDoToday < Sinatra::Base

  # Index
  # -----------------------------------------------------------

  get '/' do
    @sessionUser = env['warden'].user
    @venues = Venue.all
    @route = 'index'
    unless @sessionUser.nil?
      @checkins = Venue.find(@sessionUser.checkin)
    end
    slim :"index/index"
  end
end