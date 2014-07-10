class SessionController < ApplicationController
  respond_to :json

  def oauth_create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:id] = user.id 
    redirect_to your_profile_path
  end


  def create
    @user = User.find_by_email(params[:email])
     if @user  
      if @user.guest
         session[:login_error] = "You have a guest account, please login using the link emailed to you"
        redirect_to login_path
      elsif @user && !@user.password_digest.nil? && @user.authenticate(params[:password])
        session[:id] = @user.id
        session[:login_error] =  '' if session[:login_error]
        redirect_to your_profile_path
      elsif @user && @user.password_digest.nil? 
        session[:login_error] = "You've previously made an account using Facebook login."
        redirect_to login_path
      elsif @user  && !@user.authenticate(params[:password])
        session[:login_error] =  'Incorrect Email/Password Combination'
        redirect_to login_path
      end
    else
      session[:login_error] = "No account with that email"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
