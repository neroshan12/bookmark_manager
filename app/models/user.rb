# bcrypt will generate the password hash
require 'bcrypt' # make sure 'bcrypt' is in your Gemfile
require 'data_mapper'
require 'dm-postgres-adapter'
require 'pg'

class User
  include DataMapper::Resource
  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :email, String
  # this will store both the password and the salt
  # It's Text and not String because String holds
  # only 50 characters by default
  # and it's not enough for the hash and salt
  property :password_digest, Text
  property :email, String, required: true, unique: true

  # when assigned the password, we don't store it directly
  # instead, we generate a password digest, that looks like this:
  # "$2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa"
  # and save it in the database. This digest, provided by bcrypt,
  # has both the password hash and the salt. We save it to the
  # database instead of the plain password for security reasons.

  # validates_confirmation_of is a DataMapper method
# provided especially for validating confirmation passwords!
# The model will not save unless both password
# and password_confirmation are the same
# read more about it in the documentation
# http://datamapper.org/docs/validations.html
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  validates_confirmation_of :password
  validates_format_of :email, as: :email_address
end
