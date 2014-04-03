class EventsController < ApplicationController
  respond_to :json, :html
  before_filter :check_permissions, :only => [:edit, :add_image, :destroy]
  before_filter :logged_in?, :only => [:new, :update, :create]
 
  def show
    if current_user
      @user = current_user 
    else
      @user = User.new
    end
    @event = Event.find(params[:id])
    @assigned_items = @user.assigned_items.build
    @user.event_items.build.item = Item.new
  end

  def invitation
    if current_user
      @user = current_user 
    else
      @user = User.new
    end
    @event = Event.find_by_url(params[:url])
    @assigned_items = @user.assigned_items.build
    render 'show'
  end

  def new
    @event = Event.new
    @event.event_items.build.item = Item.new
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def add_image
    @event = Event.find(params[:id])
  end

  def add_items
    @event = Event.find(params[:id])
  end

  def create
    p params
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      puts @event.errors.full_messages
      redirect_to invitation_path(@event.url)
    else
      render 'new'
    end
  end

  def update
    @event = Event.find(params[:id])
    puts params
    if @event.update_attributes(params[:event])
      redirect_to event_path
    else
      redirect_to edit_event_path
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.xml  { head :ok }
    end
  end

  def contributions
    @event = Event.find(params[:id])
  end
 def event_params
    params.require(:event).permit(:date, :description, :name, 
  :location, :name, :start_time, 
  :event_items_attributes, :state, :city, :zip, :event_type, 
  :allow_guest_create, :image, :image_updated_at,
  :host_name, :type, :end_time, :street_address, :remote_image_url, 
  :image_file_name, :image_content_type, :image_file_size,  event_items_attributes:  
  [ :name, :quantity_needed ], item_attributes: [:description, :_destroy])
  end
end

# {"name"=>"amy", "host_name"=>"amy", 
#   "event_type"=>"bbq", "date"=>"11/13/2015", "start_time"=>"8", 
#   "end_time"=>"8", "location"=>"home", "street_address"=>"100 broderick ", 
#   "city"=>"san francisco ", "state"=>"ca", "zip"=>"94117", "description"=>"adjlkdafjkdlaf", 
#   "allow_guest_create"=>"0", 
#   "event_items_attributes"=>{"1396231210528"=>{"item_attributes"=>{"name"=>"afdadf"}, 
#   "quantity_needed"=>"3000", "description"=>"dafadadf", "_destroy"=>"false"}, 
#   "1396231210527"=>{"item_attributes"=>{"name"=>""}, "quantity_needed"=>"1",
#    "description"=>"", "_destroy"=>"false"}, "1396231210306"=>
#    {"item_attributes"=>{"name"=>""}, "quantity_needed"=>"1", "description"=>"", 
#    "_destroy"=>"false"}, "1396231210305"=>{"item_attributes"=>{"name"=>""}, 
#    "quantity_needed"=>"1", "description"=>"", "_destroy"=>"false"}, 
#    "1396231209791"=>{"item_attributes"=>{"name"=>""}, "quantity_needed"=>"1", 
#    "description"=>"", "_destroy"=>"false"}, "1396231209790"=>{"item_attributes"=>
#     {"name"=>""}, 
# "quantity_needed"=>"1", "description"=>"", "_destroy"=>"false"}, "0"=>
# {"item_attributes"=>{"name"=>""}, "quantity_needed"=>"1", "description"=>"", 
# "_destroy"=>"false"}}}, "commit"=>"Save Event"}