ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative './models/link'
require_relative 'data_mapper_setup.rb'
require_relative 'models/user'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
  user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
  session[:user_id] = user.id
  redirect to('/links')
end

  helpers do
  def current_user
   @current_user ||= User.get(session[:user_id])
    end
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/confirm' do
    link = Link.create(url: params[:url], title: params[:title])
    params[:tag].split.each do |tag|
    link.tags << Tag.first_or_create(name: tag)
    link.tags
  end
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end
end
