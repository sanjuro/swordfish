class GithubIssue

	attr_reader :id, :number, :body, :name, :assignee, :state, :priority, :client, :category, :labels, :comments

	def initialize(hash)

		@id = hash["id"]
		@number = hash["number"]
		@name = hash["name"]
		@body = hash["body"]
		@assignee = GithubUser.new hash["assignee"] unless hash["assignee"].nil?
		@state = hash["state"]
		@labels = hash["labels"]
		@comments = hash["comments"]
		
		get_labels hash

	end

	def get_labels(hash)
		hash["labels"].each do |label|

			if label["name"].match('(^C:+)\W(.+)')
				@client = label["name"].match('(^C:+)\W(.+)')[2]
			end

			if label["name"].match('(^Cat:+)\W(.+)')
				@category = label["name"].match('(^Cat:+)\W(.+)')[2]
			end

			if label["name"].match('(^P:+)\W(.+)')
				@priority = label["name"].match('(^P:+)\W(.+)')[2]
			end
		end
	end
end