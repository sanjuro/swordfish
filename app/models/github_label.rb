class GithubLabel

	attr_reader :id, :name, :url, :type

	def initialize(hash)
		@id = hash["id"]
		@name = hash["name"]
		@url = hash["url"]
	end

  def process_label(name)
    if name.match('(^C:+)\W(.+)')
    	return 'client'
    end

    if name.match('(^Cat:+)\W(.+)')
    	return 'category'
    end

    if name.match('(^P:+)\W(.+)')
    	return 'priority'
    end

  end

end