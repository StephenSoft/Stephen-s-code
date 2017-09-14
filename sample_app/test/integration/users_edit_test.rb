require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:green)
	end
	
	test "unsuccessful deit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), params: { user: { name: "",
																							email: "greenday@example",
																							password: "123456",
																							password_confirmation: "123456"}}
		assert_template 'users/edit'
	end
	
	test "successful edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		name = 'Green Day'
		email = 'greenday@example.com'
		patch user_path(@user), params: { user: { name: name,
																							email: email,
																							password:							 "123456",
																							password_confirmation: "123456"}}
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal name, @user.name
		assert_equal email, @user.email
	end
	
	test "successful edit with friendly forwarding" do
		get edit_user_path(@user)
		log_in_as(@user)
		assert_redirected_to edit_user_url(@user)
		name = 'Green Day'
		email = 'greenday@example.com'
		patch user_path(@user), params: { user: { name: name,
																							email: email,
																							password:							 "123456",
																							password_confirmation: "123456"}}
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal name, @user.name
		assert_equal email, @user.email
	end
	
end























