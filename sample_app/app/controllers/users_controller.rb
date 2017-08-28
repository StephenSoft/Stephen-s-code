class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
  	#debugger
  end
  
  def new
  	@user = User.new
  end
  
  def create
  	@user = User.new(user_params) #不是最後的實現方式
  	if @user.save
  		#處理成功
  		log_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
  	
  private
  
  	def user_params
  		params.require(:user).permit(:name, :email, :password,
  				  											 :password_conrirmation)
  	end  
  
end
