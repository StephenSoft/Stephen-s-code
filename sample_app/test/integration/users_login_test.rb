require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = users(:green)
	end

  test "login with valid information followed by logout" do
  	get login_path
  	post login_path, params: { session: { email:    @user.email,
  																				password: 'password' } }
		
		assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
 		delete logout_path
 		assert_not is_logged_in?
 		assert_redirected_to root_url
 		#模擬用戶在另一個窗口中點擊退出鏈接
 		delete logout_path
 		follow_redirect!
 		assert_select "a[href=?]",login_path
 		assert_select "a[href=?]",logout_path,      count: 0
 		assert_select "a[href=?]",user_path(@user), count: 0
  end 
  
  test "login with remembering" do
  	log_in_as(@user, remember_me: '1')
  	assert_not_empty cookies['remember_token']
  end
  
  test "login without remembering" do
		#登錄， 設定 cookie
		log_in_as(@user, remember_me: '1')
		delete logout_path
		#再次登錄， 確認 cookie 被刪除了
		log_in_as(@user, remember_me: '0')
		assert_empty cookies['remember_token']
  end
end
