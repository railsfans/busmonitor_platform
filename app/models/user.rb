require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :email, :password, :role, :username, :password_confirmation, :phone, :realname, :sex, :logintime, :loginip, :logincity, :new_token
	validates :password, :confirmation => true, :presence => true, :if => :password_required?
	before_save :encrypt_new_password
	after_update :flush_name_cache
	
	def flush_name_cache
		p 'change password' if hashed_password_changed?
	end

	def self.authenticate(username, password)
		user = find_by_username(username)
		return user if user && user.authenticated?(password) && user.username==username
	end
	
	def authenticated?(password)
		self.hashed_password == encrypt(password)
	end
	
	protected
	
	def encrypt_new_password
		return if password.blank?
		self.hashed_password = encrypt(password)
	end
	
	def password_required?
		hashed_password.blank? || password.present?
	end
	
	def encrypt(string)
		Digest::SHA1.hexdigest(string)
	end
	
	def self.authenticate_user(user_id, password)
		user = find_by_id(user_id)
		return user if user && user.authenticated?(password)
	end
	
end
