class UsersController < ApplicationController
  respond_to :json, :html
  before_filter :logged_in?, :only => [:show, :edit, :update, :destroy, :your_profile]
  before_filter :load_and_authorize_user, :only => [:show, :edit, :update, :destroy]

  def your_profile
    @user = current_user
    @event = Event.new
    @event.event_items.build.item = Item.new
    render :show
  end

  def simple_login
    @login_error = session[:login_error]
  end

  def create_guest
    @user = User.find_by_email(person_params[:email]) 
    items = person_params[:items] || []
    if @user
      @user.add_items(items)
    else
      @user = User.new
      @user.name = person_params[:name]
      @user.email = person_params[:email]
      @user.guest = true
      @user.save!
      @user.add_items(items)
    end 
    if @user.save && @user.guest
      render :js => "window.location = '/guest/#{@user.url}/'"
    elsif 
      render :js => "window.location = '/your_profile/'"
    else 
      puts @user.errors.full_messages
    end
  end

  def create 
    @user = User.new(person_params)
    if @user.save
      session[:id] = @user.id
      redirect_to your_profile_path
    else
      redirect_to login_path
    end 
  end

  def destroy
    @user.destroy
  end

  def guest
    @user = User.find_by_url(params[:url])
    session[:id] = @user.id
    render :show
  end

  private

  def person_params
    params.require(:user).permit(:name, :email, :guest, :password, :password_confirmation, 
      :items => [:name, :description, :id, :amountPromised, :quantity, :amountToBring, :eventId, :stillNeeded]
      )
  end
end