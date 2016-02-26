class GithubService

  attr_reader :access_token

  def initialize(access_token = nil)
    @access_token = access_token if access_token
  end

  def authenticate!(client_id, client_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token",
        {client_id: client_id, client_secret: client_secret, code: code},
        {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    @access_token = access_hash["access_token"]
  end

  def get_username
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    user_json["login"]
  end

  def get_repos
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    repos_array = JSON.parse(response.body)
    repos_array.map{|repo| GithubRepo.new(repo) }
  end

  def get_issues(user, repo, page = 1)
    response = Faraday.get "https://api.github.com/repos/#{user}/#{repo}/issues?page=#{page}", {}, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    issues_array = JSON.parse(response.body)
    issues_array.map{|issue| GithubIssue.new(issue) }
  end

  def create_issue(user, repo, params)
    params = {
        title: params[:title], 
        body: params[:body], 
        labels: [params["client"], params["priority"], params["category"]], 
      }

    response = Faraday.post "https://api.github.com/repos/#{user}/#{repo}/issues", params.to_json, {'Authorization' => "token #{ENV['GTIHUB_TOKEN']}", 'Accept' => 'application/json'}
    JSON.parse(response.body)
  end

  def get_labels(user, repo, type)
    response = Faraday.get "https://api.github.com/repos/#{user}/#{repo}/labels", {}, {'Authorization' => "token #{self.access_token}", 'Accept' => 'application/json'}
    labels_array = JSON.parse(response.body)
    labels_array.map{|label| GithubLabel.new(label) }
    labels_array = process_labels labels_array
    labels_array.select {|label| label["type"] == type}
  end

  def process_labels(labels)
    labels.each do |label|
      if label["name"].match('(^C:+)\W(.+)')
        label["type"] = 'client'
      end

      if label["name"].match('(^Cat:+)\W(.+)')
        label["type"] = 'category'
      end

      if label["name"].match('(^P:+)\W(.+)')
        label["type"] = 'priority'
      end
      labels
    end
  end
end