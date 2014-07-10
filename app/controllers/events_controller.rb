class EventsController < ApplicationController
  respond_to :json, :html
  before_filter :check_permissions, :only => [:edit, :add_image, :destroy, :update]
  before_filter :logged_in?, :only => [:new, :update, :create]

  def index
    @event = Event.find(params[:id])
    hash = @event.to_ko
    render json: hash
  end

  def show
    @event = Event.find(params[:id])
    render 'show'
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
    event = Event.create(event_params)
    event.user_id = current_user.id
    event.date = Chronic.parse(event_params[:date])
    if event.save 
      render :js => "window.location = '/events/#{event.id}/edit'"
    else
      puts event.errors.full_messages
      render json: event.errors.full_messages
    end
  end

  def update
    event = Event.find(params[:id])
    event.update_items(event_params[:items], event.id) if event_params[:items]
    event.delete_items(event_params[:deletedItems])
    event_params.delete([:deletedItems])
    event.update_attributes(event_params)
    event.save!
    p event.errors.full_messages
    render json: event 
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
    end
  end

  def contributions
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:id, :date, :description, :name, 
      :location, :name, :start_time,
      :event_items_attributes, :state, :city, :zip, :event_type, 
      :allow_guest_create, :image, :image_updated_at,
      :host_name, :type, :end_time, :street_address, :remote_image_url, :image,
      :image_file_name, :image_content_type, :image_file_size, 
      :items => [:name, :description, :id, :amountPromised, :quantity, :amountToBring, :eventId, :stillNeeded],  :deletedItems => [])
  end
end
