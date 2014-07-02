class UsersController < ApplicationController
  respond_to :json, :html
  before_filter :logged_in?, :only => [:show, :edit, :destroy, :your_profile]
  before_filter :load_and_authorize_user, :only => [:show, :edit, :destroy]

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
    email = person_params[:email] || current_user.email
    @user = User.find_by_email(email) 
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

  def update 
    if current_user.nil?
      @user = User.find_by_url(person_params[:url])
      @user.update(person_params)
      @user.guest = false
      @user.url = nil
      @user.save!
      session[:id] = @user.id
      redirect_to your_profile_path
    else
      current_user.update(person_params)
      current_user.save!
      redirect_to your_profile_path
    end
  end

  def guest
    @user = User.find_by_url(params[:url])
    if @user
      render :show
    else 
      redirect_to login_path
    end
  end

  private

  def person_params
    params.require(:user).permit(:name, :email, :guest, :url, :password, :password_confirmation, 
      :items => [:name, :description, :id, :amountPromised, :quantity, :amountToBring, :eventId, :stillNeeded]
      )
  end
end