module SessionsHelper
	#登錄指定用戶
	def log_in(user)
		session[:user_id] = user.id
	end
	
	#在持久會話中記住用戶
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	
	end
	
	#如果指定用戶是當前用戶返回true
	def current_user?(user)
		user == current_user
	end
	
	#返回kookie中記憶令牌指定用戶
	def current_user
		#@current_user ||= User.find_by(id: session[:user_id])
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(:remember, cookies[:remember_token])
				log_in user
				@current_user = user
			end		
		
		end
	end
	
	#如果用戶已登錄，返回true 否則返回false
	def logged_in?
		!current_user.nil?	
	end
	
	#忘記持久會話
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end
	
	
	#退出當前用戶
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end
	
	#重定向到存儲的地址或者默認的地址
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end
	
	#存儲後面需要使用的地址
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end
	
end














