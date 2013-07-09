class AssignedItemsController < ApplicationController

	def create
		assigned_item = current_user.assigned_items.build(params[:assigned_item])
		if assigned_item.save
			redirect_to user_path(current_user)
		end
	end

	def destroy
		@item = AssignedItem.find(params[:format])
		@item.destroy
		respond_to do |format|
			format.html { redirect_to user_path(current_user) }
			format.xml  { head :ok }
		end
	end

end

