class IssuesController < ApplicationController
	before_action :authenticate_user!
	respond_to :html,:json

	def index
		user = 'WorkAtSwordfish'
		repo = 'GitIntegration'
		@issues = get_issues(user, repo, params[:page])
		respond_with(@issues)
	end

	def new
		user = 'WorkAtSwordfish'
		repo = 'GitIntegration'
		@categories = get_labels(user, repo, 'category')
		@priorities = get_labels(user, repo, 'priority')
		@clients = get_labels(user, repo, 'client')
	end

	def create
		user = 'WorkAtSwordfish'
		repo = 'GitIntegration'
		@issue = create_issue(user, repo, params)
		
		if @issue
			@issues = get_issues(user, repo, params[:page])
			respond_with(@issues)
		else

		end
	end

  def get_issues(user, repo, page = 1)
    GithubService.new(session[:token]).get_issues(user, repo, page)
  end

  def create_issue(user, repo, params)
    GithubService.new(session[:token]).create_issue(user, repo, params)
  end

  def get_labels(user, repo, type)
    labels_array = GithubService.new(session[:token]).get_labels(user, repo, type)
    labels_array.collect {|label| label["name"]}
  end
end