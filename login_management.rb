class LoginManager < Sinatra::Base
  get "/" do
    slim :"index/index"
  end
 
  post '/unauthenticated/?' do
    status 401
    slim :login
  end
 
  get '/login/?' do
    slim :login
  end
  
  post '/login/?' do
    env['warden'].authenticate!
    redirect "/"
  end
  
  get '/logout/?' do
    env['warden'].logout
    redirect '/'
  end
end