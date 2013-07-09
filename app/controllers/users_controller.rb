class UsersController < ApplicationController
  before_filter :logged_in?, :only => [:show, :edit, :update, :destroy]
  before_filter :load_and_authorize_user, :only => [:show, :edit, :update, :destroy]

  def your_profile
    @user = current_user
    @event = Event.new
    @event.event_items.build.item = Item.new
    render :show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email]) 
    if @user
      params["user"]["assigned_items_attributes"].each do |e|
        @user.assigned_items << AssignedItem.new(quantity_provided: e[1]["quantity_provided"], event_item_id: e[1]["event_item_id"])
       redirect_to guest_path(@user.url)
      end
    else
      @user = User.new(params[:user])
      if @user.save
       Rails.logger.info(@user.errors.inspect) 
       session[:id] = @user.id unless @user.guest
        # UserMailer.signup_confirmation(@user.id).deliver
        redirect_to guest_path(@user.url)
      else
       Rails.logger.info(@user.errors.inspect) 
       flash[:errors] = @user.errors.messages
       redirect_to root_path
     end 
   end
 end

  def destroy
    @user.destroy
  end

  def guest
    @user = User.find_by_url(params[:url])
    render 'users/guest'
  end
end

# class GuestsController < ApplicationController
#   # before_filter :find_or_create_guest, :only => [:create]
#   def create
#     @guest = Guest.find_by_email(params[:guest][:email]) 
#     if @guest
#       params["guest"]["assigned_items_attributes"].each do |e|
#         @guest.assigned_items << AssignedItem.new(quantity_provided: e[1]["quantity_provided"], event_item_id: e[1]["event_item_id"])
#       end
#     else
#        @guest = Guest.create(params[:guest])
#     end
#     Rails.logger.info(@guest.errors.inspect) 
#     redirect_to rsvp_path(@guest.url)
#   end

#   def rsvp
#     @guest = Guest.find_by_url(params[:url])
#     render :show
#   end

#   def show
#    @guest = Guest.find_by_url(params[:url])
#    render :show
#  end 
# end


