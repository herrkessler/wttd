class WhatToDoToday < Sinatra::Base

  # Blog
  # -----------------------------------------------------------

  get '/tour' do
    @sessionUser = env['warden'].user
    slim :"tour/index"
  end
  
end