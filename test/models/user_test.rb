require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:one)
  end

  test "require_email" do
    user = User.new(email: '', password: 'Password', password_confirmation: 'Password', nickname: 'Sloww', first_name: 'Leon', last_name: 'Pokrityuk' )
    assert_not user.valid? , 'Email should be present'
  end

  test 'email_validation_should_fail' do
    user = User.new(nickname: 'someName', first_name: 'Leon', last_name: 'Pokrityuk', email: 'someemail.gmail.com')
    assert_no_match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, user.email, 'not valid')
  end

  test "require_first_name" do
    user = User.new( first_name: '', email: 'p.leonid@gmail.com', password: 'Password', password_confirmation: 'Password', nickname: 'Sloww',  last_name: 'Pokrityuk' )
    assert_not user.valid? , 'first name is missing'
  end

  test "require_last_name" do
    user = User.new( last_name: '' , first_name: 'Leon', email: 'p.leonid@gmail.com', password: 'Password', password_confirmation: 'Password', nickname: 'Sloww')
    assert_not user.valid? , 'last name is missing'
  end

  #tests for password on create
  test 'valid_password' do
    user = User.new(email: 'p.leonid@gmail.com', password: 'Password', password_confirmation: 'Password', nickname: 'Sloww', first_name: 'Leon', last_name: 'Pokrityuk' )
    assert user.valid?
  end

  test 'require_password' do
    user = User.new(email: 'p.leonid@gmail.com', password: '', password_confirmation: 'Password', nickname: 'Sloww', first_name: 'Leon', last_name: 'Pokrityuk' )
    assert_not user.valid?
  end

  test 'require_password_confirmation' do
    user = User.new(email: 'p.leonid@gmail.com', password: 'Password', password_confirmation: '', nickname: 'Sloww', first_name: 'Leon', last_name: 'Pokrityuk' )
    assert_not user.valid?
  end

  test 'confirmation_does_not_match' do
    user = User.new(email: 'p.leonid@gmail.com', password: 'Password', password_confirmation: 'Passwordd', nickname: 'Sloww', first_name: 'Leon', last_name: 'Pokrityuk' )
    assert_not user.valid?
  end

  test 'password_and_password_confirmation_are_missing' do
    user = User.new(email: 'p.leonid@gmail.com', password: '', password_confirmation: '', nickname: 'Sloww', first_name: 'Leon', last_name: 'Pokrityuk' )
    assert_not user.valid?
  end

  #tests for password on update
  test "update_password_without_confirmation" do

    @user.update(password: 'Password', password_confirmation: '')
    assert_not @user.valid?, 'Password_confirmation is missing'
  end

  test "update_password_without_entering_one" do

    @user.update(password: '', password_confirmation: 'Password')
    assert_not @user.valid?, 'Password is missing'
  end

  test "update_with_wrong_confirmation" do

    @user.update(password: 'Password', password_confirmation: 'Passwordddd')
    assert_not @user.valid?, 'confirmation and password do not match'
  end


  test "password_update" do
    @user.update( password: 'Password', password_confirmation: 'Password')
    assert @user.valid?
  end

  test "should_pass_password_update_procedure" do
    assert_equal true, @user.valid_password?('testtest'), 'password isnt valid'
    @user.update( password: 'Password', password_confirmation: 'Password')
    assert @user.valid?
  end

  test "current_password_is_wrong" do
    assert_equal false, @user.valid_password?('wrongPassword'), 'password isnt valid'
    @user.update( password: 'Password', password_confirmation: 'Password')
    assert @user.valid?
  end

  test "password_is_wrong" do
    assert_equal true, @user.valid_password?('testtest'), 'password isnt valid'
    @user.update( password: 'wrongPassword', password_confirmation: 'Password')
    assert_not @user.valid?
  end

  test "confirmation_password_is_wrong" do
    assert_equal true, @user.valid_password?('testtest'), 'password isnt valid'
    @user.update( password: 'Password', password_confirmation: 'wrongPassword')
    assert_not @user.valid?
  end

end
