class SessionController < ApplicationController
  respond_to :json

  def oauth_create

    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:id] = user.id 
    redirect_to your_profile_path
  end


  def create
    @user = User.find_by_email(params[:email])
    p @user.password.nil?
    if @user && @user.password.nil?
      puts 'user has password'
      @user.authenticate(params[:password])
      session[:id] = @user.id
      session[:login_error] =  '' if session[:login_error]
      redirect_to your_profile_path
    else
      puts 'user does not have password'
      session[:login_error] =  'Incorrect Email/Password Combination'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
