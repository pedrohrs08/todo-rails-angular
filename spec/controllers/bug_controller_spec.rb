require 'rails_helper'

RSpec.describe BugController, :type => :controller do
	render_views

	context "when logged out" do 
	    it "should not be able to access index" do
	      get :index
	      expect(response).to redirect_to(new_user_session_path)
	    end
	end

	context "when logged in" do
      login_user_before_each
      
      before(:each) do
      	@user1 = @current_user
      	@user2 = FactoryGirl.create(:user)
        (0..10).each do |index|
 			FactoryGirl.create(:bug, user: (index % 2 == 0 ? @user1 : @user2))
        end
      end

      it "should return the bugs for the logged user" do
      	 get :index, format: :json
      	 json = JSON.parse(response.body)
      	 user_ids = json.each.collect { |json| json["user_id"] }
         expect(user_ids).to all(eq(@current_user.id))
      end
    end
end
