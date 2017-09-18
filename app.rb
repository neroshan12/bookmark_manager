require 'sinatra'
require 'rack'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb(:index)

  run! if app_file == $0
end
