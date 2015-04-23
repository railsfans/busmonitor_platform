require "open-uri"
require 'rubygems'
require 'json'
require 'active_support/secure_random'

class ApplicationController < ActionController::Base
	protect_from_forgery
	protected
	
	helper_method :current_user
	helper_method :logged_in?
	helper_method :locateIp
	helper_method :new_token
	
	def real_ip(request)  
  		request.env['HTTP_X_FORWARDED_FOR'].present? ? request.env['HTTP_X_FORWARDED_FOR'] : request.remote_ip  
	end  

	# Returns a random token.
  	def new_token
    	SecureRandom.urlsafe_base64
  	end

	def current_user
		return unless session[:user_id]
		@current_user ||= User.find_by_id(session[:user_id])
	end
	
	def authenticate
=begin cookie version
		p 'this is application'
		p cookies.signed[:new_token]
		p current_user
		logged_in?  && current_user.new_token==cookies.signed[:new_token] ? true : access_denied
=end
		logged_in?  ? true : access_denied
	end
	
	def logged_in?
		current_user.is_a? User
	end
	
	def access_denied
		redirect_to login_path, :notice => t('Please log in to continue')
		return false
	end 

	 def index
    	@location = locateIp()
	end

  	def locateIp
#   	ip = "123.123.123.123";
#		ip = real_ip request
    	ip = request.remote_ip
    	ips = ip.to_s
		uri = 'http://ip.taobao.com/service/getIpInfo.php?ip='+ips
		response = nil
		open(uri) do |http|
  			response = http.read
		end
		@res = JSON::parse(response)
		if @res["data"]["country_id"]!="IANA"
			ipLocation = @res["data"]["country"] +", "+@res["data"]["city"]
		else
			ipLocation="unknow region"
		end
		return ipLocation
	end  #end of method locateIp

end
