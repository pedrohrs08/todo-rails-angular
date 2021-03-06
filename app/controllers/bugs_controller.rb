class BugsController < ApplicationController

	 before_action :authenticate_user!

	 before_action :set_bug, only: [:update, :destroy]

	 respond_to :json
	 
	 def index
        respond_to do |format|
           format.html
           format.json { render json: Bug.by_user(current_user.id) }
        end
	 end

	 def create
	 	respond_with current_user.bugs.create(bug_params)
	 end
     
     def update
     	@bug.update(bug_params)
        respond_with @bug, location: ''
     end

	 def destroy
	    respond_with @bug.destroy!
	 end

	 private
     def set_bug
	   @bug = current_user.bugs.find(params[:id])
     end 

	 def bug_params
	 	params.require(:bug).permit(:summary,:description,:priority)
	 end
end
