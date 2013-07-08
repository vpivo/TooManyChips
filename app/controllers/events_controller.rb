class EventsController < ApplicationController
  respond_to :json, :html
  before_filter :format_date, :only => [:create, :update]
  before_filter :get_event_type_id, :only => [:create, :update]

  def show
    @event = Event.find(params[:id])
    @user = current_user ||= User.new
    @assigned_items = @user.assigned_items.build
    @user.event_items.build.item = Item.new

  end

  def invitation
    @event = Event.find_by_url(params[:url])
    redirect_to event_path(@event)
  end

  def new
    @event = Event.new
    @event.event_items.build.item = Item.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])
    @event.user_id = current_user.id
    if @event.save
      redirect_to event_path(@event)
    else
      render 'users/show'
    end
  end

  def update
    @event = Event.find(params[:id])
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

  def check_permissions
    @event = Event.find(params[:id])
    unless current_user.id == @event.user.id
     redirect_to event_path(@event)
   end

 end

 def logged_in?
  unless current_user
    flash[:error] = "You must be logged in to access this section"
    redirect_to root_path
  end
end


end

