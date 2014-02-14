require 'bcrypt'

class User

	include DataMapper::Resource

	property :id,								Serial
	property :name,							String
	property :username, 				String
	property :email,						String
	property :password_digest,	Text

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password, message: 'Sorry, your passwords do NOT match!'

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

end