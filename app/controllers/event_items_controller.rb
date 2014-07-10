class EventItemsController < ApplicationController

  def destroy
    event_item = EventItem.find(event_item_params[:id])
    event_item.destroy
    respond_to do |format|
      format.js { render :json => 'deleted' }
    end
  end

  def event_item_params
    params.require(:item).permit(:id) 
  end
end

