class RepositoriesController < ApplicationController
	before_action :authenticate_user!
	respond_to :html, :json, :xml

	def index
		@repositories = get_repos
		respond_with(@repositories)
	end

  def get_repos
    GithubService.new(session[:token]).get_repos
  end
end