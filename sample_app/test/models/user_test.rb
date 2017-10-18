require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
  	@user = User.new(name: "Example User", email: "user@example.com",
  									 password: "foobar", password_confirmation: "foobar") 
  
  end 
  
  test "authenticated? should return false for a user with nil digest" do
  	assert_not @user.authenticated?(:remember, '') 
  end
  
  test "should be valid" do
  	assert @user.valid?
  end 
  
  test "name should be present" do
  	@user.name = "     "
  	assert_not @user.valid? 
  end
  
  test "email should be present" do
  	@user.email = "     "
  	assert_not @user.valid?
  end
  
  test "name should not be too long " do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end
  
  test "email should not be too long " do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end
  
  test "email validation should accept valid adderss" do
  	invalid_address = %w[user@example,com user_at_foo.org
 user.name@example.
 											 foo@bar_baz.com foo@bar+baz.com]
 		invalid_address.each do |invalid_add|
 			@user.email = invalid_add
 			assert_not @user.valid?, "#{invalid_add.inspect} should be invalid	" 		
 		end 	
  end
  
  test "email address should be unique" do
  	duplicate_user = @user.dup
  	#解決大小寫問題
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end
  
  test "password should be present (nonblank)" do
  
  	@user.password = @user.password_confirmation = " " * 6
  	assert_not @user.valid?
  end 
  
  test "password should have a minimun length" do
  	@user.password = @user.password_confirmation = "a" * 5 
  	assert_not @user.valid?
  end
  
    
  
  
  
  
end





