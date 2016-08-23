class WhatToDoToday < Sinatra::Base

  # Blog
  # -----------------------------------------------------------

  get '/blog' do
    @posts = Post.all(:order => [:created_at.desc])
    slim :"post/index"
  end

  get '/blog/new' do
    if env['warden'].user.admin?
      @post = Post.new
      slim :"post/new"
    else 
      flash[:error] = 'Youre not the admin'
      redirect to('/')
    end
  end

  post '/blog' do
    @post = Post.create(params[:post])
    flash[:success] = 'Neuer Post: "' + @post.title + '" angelegt'
    redirect to("/blog/#{@post.id}")
  end

  get '/blog/:id' do
    @post = Post.get(params[:id])
    slim :"post/show"
  end
  
end