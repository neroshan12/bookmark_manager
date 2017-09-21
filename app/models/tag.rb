require 'data_mapper'
require 'dm-postgres-adapter'
require 'pg'

class Tag
  include DataMapper::Resource

  has n, :links, through: Resource

  property :id,   Serial
  property :name, String

end
