class UserProfileController < ApplicationController

  def index
    @user = User.find_by_id(current_user.id)

  end

  def update
    @user = get_user
    begin
      User.transaction do
        @user.update_attributes!(user_params)
        flash[:success] = "Your profile has been updated"
      end
    rescue
      flash[:error] = @user.errors.full_messages.first if @user.errors.any?
    end
    redirect_to action: 'index'
  end



  private

  def get_user
   @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :nickname, :date_of_birth, :phone_number, :address)
  end

end