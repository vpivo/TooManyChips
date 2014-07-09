class SessionController < ApplicationController
  respond_to :json

  def oauth_create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:id] = user.id 
  end


  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.password != nil
      @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect_to your_profile_path
      session[:login_error] =  '' if session[:login_error]
    else
      session[:login_error] =  'Incorrect Email/Password Combination'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
