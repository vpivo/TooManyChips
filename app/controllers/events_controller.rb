class EventsController < ApplicationController
  respond_to :json, :html
  before_filter :check_permissions, :only => [:edit]
  before_filter :logged_in?, :only => [:new, :create]
 
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

  
end

