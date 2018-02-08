class UserProfileController < ApplicationController

  def index
    @user_profile = UserProfile.find_by_user_id(current_user.id)
    @current_user = @user_profile.user

  end

end