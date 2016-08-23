require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'
require 'active_record'
require 'pg'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/assetpack'
require 'postgres_ext'
require './models'

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database =>  'whattodotoday'
)

class WhatToDoToday < Sinatra::Base

  # -----------------------------------------------------------
  # Sinatra Settings
  # -----------------------------------------------------------

  set :root, File.dirname(__FILE__)
  set :environments, %w{development production}
  set :session_secret, '*&(^B234'
  set :static, true
  set :public_folder, Proc.new { File.join(root, "public") }
  set :server, 'thin'
  set :sockets, []

  # $redis = Redis.new

  enable :sessions
  enable :method_override
  enable :logging

  register Sinatra::Flash
  register Sinatra::AssetPack

  # -----------------------------------------------------------
  # Assets
  # -----------------------------------------------------------

  require 'sass'
  set :sass, { :load_paths => [ "#{WhatToDoToday.root}/assets/css" ] }

  assets do
    serve '/js',     from: 'assets/js'        # Default
    serve '/css',    from: 'assets/css'       # Default
    serve '/images', from: 'assets/images'    # Default
    serve '/fonts',  from: 'assets/fonts'     # Default

    js :application, [
      '/js/lib/jquery-2.1.3.js',
      '/js/lib/picturefill.js',
      '/js/lib/webfontloader.js',
      '/js/lib/haversine.js',

      '/js/specific/menu.js',
      '/js/specific/font.js',
      '/js/specific/dist.js',
      '/js/specific/logout.js',
      '/js/specific/venue.js',
    ]

    css :application, '/css/application.sass', [
      '/css/application.css'
    ]

    js_compression  :jsmin
    css_compression :sass 
  end

  # -----------------------------------------------------------
  # Authentication with Warden
  # -----------------------------------------------------------

  use Warden::Manager do |config|
    config.serialize_into_session{|user| user.id }
    config.serialize_from_session{|id| User.where('users.id' => id).first }
    config.scope_defaults :default,
      strategies: [:password],
      action: '/unauthenticated'
    config.failure_app = self
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do

    def valid?
       params['username'] || ['password']
    end

    def authenticate!
      u = User.find_by(username: params['username']).try(:authenticate, params['password'])
      u.nil? ? fail!("Could not log in") : success!(u)
    end

  end

  # -----------------------------------------------------------
  # Helpers & Extenders
  # -----------------------------------------------------------

  helpers Gravatarify::Helper

  # -----------------------------------------------------------
  # Routes
  # -----------------------------------------------------------

  require_relative 'routes/index'
  require_relative 'routes/auth'
  require_relative 'routes/venue'
  require_relative 'routes/user'
  require_relative 'routes/blog'
  require_relative 'routes/message'
  require_relative 'routes/admin'
  require_relative 'routes/tour'
  require_relative 'routes/event'
  require_relative 'routes/trip'
  require_relative 'routes/category'

end


