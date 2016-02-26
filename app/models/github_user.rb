class GithubUser

	attr_reader :login, :id, :avatar_url

	def initialize(hash)
		@login = hash["login"]
		@id = hash["id"]
		@avatar_url = hash["avatar_url"]
	end

end