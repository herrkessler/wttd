class WhatToDoToday < Sinatra::Base

  # Categories
  # -----------------------------------------------------------

  get '/categories' do
    @categories = Category.all
    slim :"category/index"
  end
  
end