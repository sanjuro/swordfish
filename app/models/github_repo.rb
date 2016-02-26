class GithubRepo

	attr_reader :id, :name, :full_name, :url, :type

	def initialize(hash)
		@id = hash["id"]
		@name = hash["name"]
		@full_name = hash["full_name"]
		@url = hash["html_url"]
	end

end