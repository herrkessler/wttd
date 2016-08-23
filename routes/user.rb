class WhatToDoToday < Sinatra::Base

  # User
  # -----------------------------------------------------------

  get '/users' do
    env['warden'].authenticate!
    if env['warden'].user.admin?
      @sessionUser = env['warden'].user
      @users = User.all(:order => [:username.asc]).paginate(:page => params[:page], :per_page => 100)
      slim :"user/index"
    else 
      flash[:error] = 'Youre not the admin'
      redirect to('/')
    end
  end

  get '/users/new' do
    @route = 'auth'
    @user = User.new
    slim :"user/new"
  end

  post '/users' do

    data = params[:user]

    if data[:username].empty? or data[:email].empty? or data[:password].empty?
      flash[:error] = 'Something was missing'
      redirect to("/users/new")
    elsif data[:password] != data[:repeated_password]
      flash[:error] = 'Your passwords did not match'
      redirect to("/users/new")
    else
      data = data.except('repeated_password')
      # admin = User.get(1)
      @user = User.create(data)

      if @user.save

        # Redirect to login

        flash[:success] = 'Hallo ' + @user.forename + ', du brauchst noch etwas Geduld... bitte bestaetige erst deine Email Adresse.'
        redirect to("/login")

      else

        flash[:error] = 'Something went wrong while signing up'
        redirect to("/users/new")

      end
    end
  end

  get '/users/:id' do
    env['warden'].authenticate!
    @user = User.find(params[:id])

    if @user != nil
      @sessionUser = env['warden'].user
      slim :"user/show"
    else
      flash[:error] = 'What you are looking for does not exist'
      redirect to("/")
    end
  end

  get '/users/:id/edit' do
    env['warden'].authenticate!
    @user = User.find(params[:id])
    slim :"user/edit"
  end

  put '/users/:id' do
    env['warden'].authenticate!
    user = User.find(params[:id])
    user.update(params[:user])
    if user.save
      flash[:success] = 'User update successful'
      redirect to("/users/#{user.id}")
    else
      flash[:error] = 'Something went wrong'
      redirect to("/users/#{user.id}/edit")
    end
  end

  # post '/users/:id/avatar' do

  #   sessionUser = env['warden'].user
  #   @filename = params[:file][:filename]
  #   file = params[:file][:tempfile]
  #   FileUtils::mkdir_p 'public/images/' + sessionUser.id.to_s
  #   filepath = 'public/images/' + sessionUser.id.to_s
  #   FileUtils.move file.to_path, File.join(filepath, params[:file][:filename])
  #   user = User.get(sessionUser.id)
  #   user.update(:avatar => @filename)
  #   if user.saved?
  #     flash[:success] = 'Bild hochgeladen'
  #     redirect to("/users/#{user.id}")
  #   else
  #     flash[:error] = 'Something went wrong'
  #     redirect to("/users/#{user.id}/edit")
  #   end
  # end

  delete '/users/:id' do
    env['warden'].authenticate!
    User.get(params[:id]).destroy
    redirect to('/')
  end

  # get '/users/:id/add' do
  #   env['warden'].authenticate!
  #   user = User.get(params[:id])
  #   sessionUser = env['warden'].user
  #   sessionUser.request_friendship(user)
  #   flash[:success] = 'Freundschaft mit ' + user.forename + ' angefragt'
  #   redirect to("/users/#{user.id}")
  # end

  # get '/users/:id/accept' do
  #   env['warden'].authenticate!
  #   user = User.get(params[:id])
  #   sessionUser = env['warden'].user
  #   user.confirm_friendship_with(sessionUser)
  #   redirect to("/users/#{sessionUser.id}")
  # end

  # get '/users/:id/delete' do
  #   env['warden'].authenticate!
  #   user = User.get(params[:id])
  #   sessionUser = env['warden'].user
  #   user.end_friendship_with(sessionUser)
  #   flash[:success] = 'Freundschaft mit ' + user.forename + ' beendet'
  #   redirect to("/users/#{sessionUser.id}")
  # end

  # Friendship Requests
  # -----------------------------------------------------------

  # get '/users/:id/friendship' do
  #   env['warden'].authenticate!
  #   @user = User.get(params[:id])
  #   slim :"user/friendship"
  # end

  # Confirm Email
  # -----------------------------------------------------------

  get '/users/:id/confirm/:code' do

    user = User.get(params[:id])
    confirmation = Confirmation.first(:code => params[:code])

    if params[:code] == confirmation.code

      confirmation.attributes = {:code => ""}
      confirmation.save

      user.attributes = {:confirmed => true}
      user.save

      flash[:new_user] = 'Prost ' + user.forename + ', es kann losgehen, log Dich ein und finde neue WhatToDoToday.'
      redirect to("/auth/login")
    else
      flash[:error] = 'Something went terribly wrong here with your email confirmation...'
      redirect to("/")
    end
  end

end