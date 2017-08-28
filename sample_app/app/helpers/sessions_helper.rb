module SessionsHelper
	#登錄指定用戶
	def log_in(user)
		session[:user_id] = user.id
	end
	
	#返回當前用戶
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end
	
	#如果用戶已登錄，返回true 否則返回false
	def logged_in?
		!current_user.nil?	
	end
	
	#退出當前用戶
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end
end
