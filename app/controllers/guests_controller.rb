class GuestsController < ApplicationController
  # before_filter :find_or_create_guest, :only => [:create]
  def create
    @guest = Guest.find_by_email(params[:guest][:email]) 
    if @guest
      params["guest"]["assigned_items_attributes"].each do |e|
        @guest.assigned_items << AssignedItem.new(quantity_provided: e[1]["quantity_provided"], event_item_id: e[1]["event_item_id"])
      end
    else
       @guest = Guest.create(params[:guest])
    end
    Rails.logger.info(@guest.errors.inspect) 
    redirect_to rsvp_path(@guest.url)
  end

  def rsvp
    @guest = Guest.find_by_url(params[:url])
    render :show
  end

  def show
   @guest = Guest.find_by_url(params[:url])
   render :show
 end 
end


