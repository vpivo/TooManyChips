class UsersController < ApplicationController
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
    @user = User.find_by_email(person_params[:user][:email]) 
    if @user
      params["user"]["assigned_items_attributes"].each do |e|
        @user.assigned_items << AssignedItem.new(quantity_provided: e[1]["quantity_provided"], event_item_id: e[1]["event_item_id"])
      end
    else
      @user = User.new(person_params[:user])
      @user.guest = true
    end 
    if @user.save
      redirect_to guest_path(@user.url) 
    end
  end

  def create 
    @user = User.new(person_params)
    if @user.save
      session[:id] = @user.id
      redirect_to your_profile_path
    else
      puts @user.errors.messages
      redirect_to login_path
    end 
  end

  def destroy
    @user.destroy
  end

  def guest
    @user = User.find_by_url(params[:url])
    render 'show'
  end

  private

  def person_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, 
      assigned_items_attributes: [:event_item_id, :quantity_provided])
  end
end
