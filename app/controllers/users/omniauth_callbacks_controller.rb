class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # @user = User.from_omniauth(request.env["omniauth.auth"])

    @user = User.find_or_create_by_github_uid(auth_hash)
    sign_in @user
    session[:token] = auth_hash['credentials']['token']
    redirect_to root_path, notice: 'You have successfully signed in!'

  end

  def failure
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end