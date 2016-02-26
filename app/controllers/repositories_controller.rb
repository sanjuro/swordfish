class RepositoriesController < ApplicationController
	before_action :authenticate_user!

	def index
		@repositories = get_repos
	end

  def get_repos
    GithubService.new(session[:token]).get_repos
  end
end