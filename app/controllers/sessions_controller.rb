class SessionsController < ApplicationController
	layout "login"
	caches_page :new
	def create
		p 'begin'
		p cookies[:user_id]
		cookies[:user_id]='123'
		p cookies[:user_id]
		cookies.signed[:user_id]='123'
		p cookies[:user_id]
		p cookies.signed[:user_id]
		p 'end'
		if  user = User.authenticate(params[:username], params[:password])  
			session[:user_id] = user.id
			cookies.signed[:user_id] = { :value=>user.id, :expires=>1.hour.from_now }
			token=new_token
			cookies.permanent.signed[:new_token]= token
			user.update_attributes(:logintime=>Time.now+8.hours, :logincity=>locateIp, :new_token=>token, :loginip=>request.remote_ip)
			redirect_to home_init_path, :notice => "Logged in successfully"
		else
			flash.now[:notice] = 'Invalid login/password combination'
			render :action => 'new'
		end
	end
	
	def destroy
		cookies.delete :user_id
		cookies.delete :new_token
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
