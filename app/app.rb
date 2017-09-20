require 'sinatra/base'
require_relative './models/link'

ENV["RACK_ENV"] ||= "development"

class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/confirm' do
    #  url = params[:url]
    #  title = params[:title]
    Link.create(url: params[:url], title: params[:title])
    redirect '/links'
  end
end
