require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		post users_path, params: { user: { name: "Stephen Zhao",
  																			email: "Stephenzhao94@e163.com",					
  																			password: "123456",
  																			password_confirmation: "123456"} }
  	end
  	follow_redirect!
  	assert_template 'users/show'
  end
end
