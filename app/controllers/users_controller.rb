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
    p "+++++++++++++++++"
    @user = User.find_by_email(person_params[:user][:email]) 
    if @user
      p user
      p params ["user"]["assigned_items_attributes"]
      # params["user"]["assigned_items_attributes"].each do |e|
      #   @user.assigned_items << AssignedItem.new(quantity_provided: e[1]["quantity_provided"], event_item_id: e[1]["event_item_id"]) if e[1]["quantity_provided"] > 0
      # end
    else
      @user = User.new(person_params[:user])
      @user.guest = true
      p user
      puts "**************************"
            p params ["user"]["assigned_items_attributes"]

      # params["user"]["assigned_items_attributes"].each do |e|
      #   @user.assigned_items << AssignedItem.new(quantity_provided: e[1]["quantity_provided"], event_item_id: e[1]["event_item_id"]) if e[1]["quantity_provided"] > 0
      # end
    end 
    if @user.save
      redirect_to guest_path(@user.url) 
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
    params.require(:user).permit(:name, :email, :guest, :password, :password_confirmation, 
      assigned_items_attributes: [:event_item_id, :quantity_provided])
  end
end
