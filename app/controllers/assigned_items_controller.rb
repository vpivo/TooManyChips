class AssignedItemsController < ApplicationController

  def create
    @assigned_item = AssignedItem.new(params[:assigned_item])
    if @assigned_item.save
      redirect_to assigned_item_path(@assigned_item)
    end
  end



end

