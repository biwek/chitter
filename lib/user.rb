require 'bcrypt'

class User

	include DataMapper::Resource

	property :id,								Serial
	property :name,							String
	property :username, 				String
	property :email,						String
	property :password_digest,	Text

	has n, :peeps, through: Resource

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password, message: 'Sorry, your passwords do NOT match!'

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first({email: email})
		if user && BCrypt::Password.new(user.password_digest) == password
			user 
		else
			nil
		end
	end

end