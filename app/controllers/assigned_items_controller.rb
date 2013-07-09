class AssignedItemsController < ApplicationController

  def create
  
    assigned_item = current_user.assigned_items.build(params[:assigned_item])
    if assigned_item.save
      redirect_to user_path(current_user)
    end
  end



end

