class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])
    
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