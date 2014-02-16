class Peep

	include DataMapper::Resource

	property :id, 						Serial
	property :post, 					String

	has 1, :user, through: Resource

end