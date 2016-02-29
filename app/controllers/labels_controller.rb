class LabelsController < ApplicationController
	respond_to :json

	def index
		user = 'WorkAtSwordfish'
		repo = 'GitIntegration'
		@labels = get_labels(user, repo)
		respond_with(@labels)
	end

  def get_labels(user, repo)
    labels_array = GithubService.new(session[:token]).get_all_labels(user, repo)
  end
end