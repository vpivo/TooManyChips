class EventsController < ApplicationController
  respond_to :json, :html
  before_filter :format_date, :only => [:create, :update]
  before_filter :check_permissions, :only => [:edit]
  before_filter :logged_in?, :only => [:new, :create]
 
  # before_filter :get_event_type_id, :only => [:create, :update]

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
    # @uploader.success_action_redirect = new_painting_url
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def add_image
    @event = Event.find(params[:id])
    # @uploader = ImageUploader.new
    # @uploader.success_action_redirect = event_path(@event)
  end

  def create
    @event = Event.new(params[:event])
    @event.user_id = current_user.id
    if @event.save
      redirect_to invitation_path(@event.url)
    else
      render 'users/show'
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

  private

  def get_event_type_id
    params[:event][:type_id] = event_type_id(params[:event][:type_id])
  end

  def event_type_id(name)
    type = Type.find_or_create_by_name(name.downcase.singularize)
    type.id
  end

  def format_date
    params[:event][:date] = Chronic.parse(params[:event][:date])
  end

  
end

