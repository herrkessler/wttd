class WhatToDoToday < Sinatra::Base

  # Login
  # -----------------------------------------------------------

  
  get '/login' do
    @route = 'auth'
    slim :"login"
  end

  post '/login' do
    @route = 'auth'
    env['warden'].authenticate!
    if session[:return_to].nil?
      sessionUser = env['warden'].user

      flash[:success] = 'Hallo ' +sessionUser.forename+ ', du hast Dich erfolgreich eingeloggt.'
      redirect to("/")
    else
      redirect session[:return_to]
    end
  end
     
  get '/logout' do
    @route = 'auth'
    sessionUser = env['warden'].user
    
    env['warden'].raw_session.inspect
    env['warden'].logout

    flash[:success] = 'Du hast Dich erfolgreich ausgeloggt.'
    redirect '/'
  end

  post '/unauthenticated' do
    @route = 'auth'
    session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?
    puts env['warden.options'][:attempted_path]
    puts env['warden']
    flash[:error] = env['warden'].message || "Invalid email or password."
    redirect '/login'
  end

end