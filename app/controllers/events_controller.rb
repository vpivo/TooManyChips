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
    p params[:event][:items]
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.date = Chronic.parse(event_params[:date])
    if @event.save
      params[:event][:items].each do |item|
        @event.event_items <<  EventItem.new(quantity_needed: 1, item_id: 1, description: :name )
      end
      render json: @event
    else
      puts @event.errors.full_messages
      render json: @event.errors.full_messages
    end
  end

  def update
    @event = Event.find(params[:id])
    puts params[:items]
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
      :image_file_name, :image_content_type, :image_file_size, :items)
  end
end
