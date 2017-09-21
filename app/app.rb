ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative './models/link'
require_relative 'data_mapper_setup.rb'

class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/confirm' do
    link = Link.new(url: params[:url],
                    title: params[:title])
    tag  = Tag.first_or_create(name: params[:tag])
    link.tags << tag
    link.save
    redirect '/links'
  end
end
