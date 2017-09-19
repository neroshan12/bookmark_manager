require 'sinatra/base'
require_relative './models/link'

class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/confirm' do
    url = params[:url]
    title = params[:title]
    Link.create(url: url, title: title)
    redirect '/links'
  end
end
