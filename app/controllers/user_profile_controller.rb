class UserProfileController < ApplicationController

  def index
    @user = User.find_by_id(current_user.id)

  end

  def update
    @user = get_current_user
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

  def change_password


    user = get_current_user

    password_validation_status = {:valid => true, :msg => 'Your password has been updated'}

    password_validation_status = process_password_validation(params[:user][:current_password], password_validation_status, user)

    if password_validation_status[:valid]
      flash[:success] = password_validation_status[:msg]

      user.update_attributes(password: params[:user][:new_password])
      bypass_sign_in(user)

    else
      flash[:danger] = password_validation_status[:msg]
    end
    redirect_to action: 'index'
  end


  def process_password_validation(current_password, password_validation_status, current_user)

    if current_password.empty?
      password_validation_status = {:valid => false, :msg => 'Please, enter your current password'}
    else
      password_validation_status = {:valid => false, :msg => 'You entered incorrect password'} unless current_user.valid_password?(current_password)
    end

    password_validation_status
  end


  private

  def get_current_user
    @user = User.find_by_id(current_user.id)
  end

  def get_user
   @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :nickname, :date_of_birth, :phone_number, :address)
  end

end