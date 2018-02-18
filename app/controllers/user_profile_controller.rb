class UserProfileController < ApplicationController

  def index
    @user = User.find_by_id(current_user.id)
  end

  def update
    password_changed = false
    user_data = user_params
    @user = current_user

    if user_data
      if params[:update_password]
        password_changed = update_password(user_data)
      elsif params[:update_profile]
        @user.update_attributes(user_data)
      else
        flash[:error] = 'Something went wrong, please try again'
      end

      if password_changed
        bypass_sign_in(@user)
      end

      if @user.errors.any?
        flash[:error] = @user.errors.full_messages.first
      else
        flash[:success] = "Your profile has been updated"
      end

      redirect_to action: 'index'
    end
  end


  def update_password(user_data)
    if @user.update_with_password(user_data)
      flash[:notice] = 'Your password has been changed'
      true
    else
      false
    end
  end


  private

  def get_current_user
    @user = User.find_by_id(current_user.id)
  end

  def get_user
   @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name,
                                 :last_name, :nickname,
                                 :date_of_birth, :phone_number,
                                 :address , :current_password,
                                 :password, :password_confirmation,)
  end

end