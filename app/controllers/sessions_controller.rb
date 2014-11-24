class SessionsController < ApplicationController
	layout "login"
	caches_page :new
	def create
		if user = User.authenticate(params[:username], params[:password])
			session[:user_id] = user.id
			redirect_to home_init_path, :notice => "Logged in successfully"
		else
			flash.now[:notice] = 'Invalid login/password combination'
			render :action => 'new'
		end
	end
	
	def destroy
		reset_session
		redirect_to root_path, :notice => "You successfully logged out"
	end
	
	def new
	end 
	def routeerror
		redirect_to login_path
#		render 'public/404.html'
	end
end
