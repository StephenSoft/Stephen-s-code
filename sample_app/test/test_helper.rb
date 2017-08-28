ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
 
  fixtures :all
  #如果用戶已經登錄，返回 true
  def is_logged_in?
  	!session[:user_id].nil? 
  end


end
