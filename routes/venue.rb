class WhatToDoToday < Sinatra::Base

  # venue
  # -----------------------------------------------------------

  get '/venues' do
    # env['warden'].authenticate!
    @sessionUser = env['warden'].user
    @categories = Category.all
    @venues = Venue.all
    slim :"venue/index"
  end

  get '/venues/:category' do
    # env['warden'].authenticate!
    # @sessionUser = env['warden'].user
    category = []
    category.push(params[:category])
    # @venues = Venue.where(Venue[:tags].eq(category))
    @venues = Venue.where.overlap(tags: category)
    @category = params[:category].capitalize
    slim :"venue/index"
  end

  get '/venues-map', :provides => :json do
    env['warden'].authenticate!
    @sessionUser = env['warden'].user
    venues = Venue.all.paginate(:page => params[:page], :per_page => 35)
    return_data = [];
    return_data << @sessionUser
    return_data << venues
    halt 200, return_data.to_json
  end

  get '/venues/new' do
    env['warden'].authenticate!
    if env['warden'].user.admin?
      @sessionUser = env['warden'].user
      @venue = Venue.new
      slim :"venue/new"
    else
      flash[:error] = 'Youre not the admin'
      redirect to('/')
    end
  end

  post '/venues' do
    env['warden'].authenticate!

    @sessionUser = env['warden'].user
    venue = Venue.create(params[:venue])

    if venue.saved? == true
      flash[:success] = 'Neuer venuent of Interest: "' + venue.title + '" angelegt'
      redirect to("/venues/#{venue.id}")
    else
      redirect to('/venues/new')
      flash[:error] = @venue
    end
  end

  get '/venue/:id' do
    # env['warden'].authenticate!
    @sessionUser = env['warden'].user

    @venue = Venue.find_by(id: params[:id])
    @nearby_venues = @venue.nearbys
    @checkins = User.where("checkin && ?", "{#{@venue.id}}")

    if @venue != nil
      slim :"venue/show"
    else
      flash[:error] = 'What you are looking for does not exist'
      redirect to("/venues")
    end
  end

  get '/checkin/:id/add' do
    env['warden'].authenticate!
    @sessionUser = env['warden'].user
    venue = Venue.find_by(id: params[:id])
    user = User.find_by(id: @sessionUser.id)
    user.checkin.push(venue.id)
    user.save
    venue.checkin.push(user.id)
    venue.save
    flash[:success] = 'Bei ' + venue.title + ' eingecheckt'
    redirect to("/venue/#{venue.id}")
  end

  get '/venues/:id/add' do
    env['warden'].authenticate!
    @sessionUser = env['warden'].user
    venue = Venue.find_by(id: params[:id])
    user = User.find_by(id: @sessionUser.id)
    user.venues << venue
    user.save
    venue.likes.push(user.id)
    venue.save
    flash[:success] = venue.title + ' zu Deinen Favouriten hinzugefügt'
    redirect to("/venue/#{venue.id}")
  end

  get '/venues/:id/delete' do
    env['warden'].authenticate!
    @sessionUser = env['warden'].user
    venue = Venue.find_by(id: params[:id])
    user = User.find_by(id: @sessionUser.id)
    user.venues.delete(venue)
    user.save
    venue.likes.delete(user.id.to_s)
    p venue.likes
    venue.save
    flash[:success] = venue.title + ' aus Deinen Favouriten entfernt'
    redirect to("/venue/#{venue.id}")
  end

end
