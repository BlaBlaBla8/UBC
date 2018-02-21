require 'test_helper'

class UserProfileControllerTest < ActionDispatch::IntegrationTest
  # include Devise::Test::IntegrationHelpers


  # test "should get index" do
  #
  #
  #   post user_profile_update_path
  #   assert_response 302
  #   assert_redirected_to user_profile_index_path
  # end

  test "should update user with password" do
    @user = users(:one)
    # sign_in(@user)

     put user_profile_update_path, params: { :user => {email: @user.email, password: '', password_confirmation: 'gfgf', current_password: "", firstname: "louis"}}
    # assert_equal(true, @user.valid_password?('fl33tsmart'))
  end

end