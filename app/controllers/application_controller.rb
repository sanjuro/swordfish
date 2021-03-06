class ApplicationController < ActionController::Base

  private

    def authenticate_user
      redirect_to "https://github.com/login/oauth/authorize?client_id=#{ENV['GITHUB_CLIENT']}&scope=repo" if !logged_in?
    end

    def logged_in?
      !!session[:token]
    end
end