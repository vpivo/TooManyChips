class GuestsController < ApplicationController

  def create
    @guest = Guest.find_by_email(params[:guest][:email]) || @guest = Guest.create(params[:guest])
    params["guest"]["assigned_items_attributes"].each do |e|
      @guest.assigned_items << AssignedItem.new(quantity_provided: e[1]["quantity_provided"], event_item_id: e[1]["event_item_id"])
    end
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


