class GithubLabel

	attr_reader :color, :name, :type

	def initialize(hash)
		@color = hash["color"]
		@name = hash["name"]
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