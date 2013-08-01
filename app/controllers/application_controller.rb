class ApplicationController < ActionController::Base
  protect_from_forgery
   include CurrentUser

  helper_method :current_user

  def load_and_authorize_user
    @user = User.find(params[:id])
    unless @user == current_user
      if current_user
        redirect_to user_path(current_user) 
      else
        redirect_to root_path
      end
    end
  end

  def check_permissions
    @event = Event.find(params[:id])
    unless current_user and current_user.id == @event.host.id
      redirect_to invitation_path(@event.url)
    end
  end

  def logged_in?
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_path
    end
  end

end


