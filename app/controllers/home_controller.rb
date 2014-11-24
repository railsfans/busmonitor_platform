class HomeController < ApplicationController
before_filter :authenticate
	def delete_cityinfo
		params[:id].split(',').each do |i|
			City.find(i).destroy
		end
		respond_to do |format|
			format.json { render :json=>{:success=>true}}
		end
	end
	def add_cityinfo
		if City.find_by_project_id(params[:project_id]).nil?
			flag=true
			City.create(:name=>params[:cityname], :ip=>params[:ip], :rootpasswd=>params[:rootpasswd], :project_id=>params[:project_id])
		else
			flag=false
		end
		respond_to do |format|
			format.json { render :json=>{:success=>flag, :errormsg=>'city project_id repeat'}}
		end
	end
	def edit_cityinfo
		if !City.find_by_project_id(params[:project_id]).nil? && City.find_by_project_id(params[:project_id]).id!=params[:id].to_i
			flag=false
		else
			flag=true
			City.find_by_id(params[:id]).update_attributes(:name=>params[:cityname], :ip=>params[:ip], :rootpasswd=>params[:rootpasswd], :project_id=>params[:project_id])
		end
		respond_to do |format|
			format.json { render :json=>{:success=>flag}}
		end
	end
	def get_personinfo
		flag=true
		@user=User.find_by_id(params[:id].to_i)
		flag=false if @user.nil?
		respond_to do |format|
			format.json { render :json=>{:success=>flag, :data=>@user }}
		end
	end

	def modify_personinfo
		flag=true
		User.find_by_id(params[:id]).update_attributes(:realname=>params[:realname],:sex=>params[:sex],:phone=>params[:phone], :email=>params[:email])
		p params[:newpasswd].nil?
		User.find_by_id(params[:id]).update_attributes(:password=>params[:newpasswd], :password_confirmation=>params[:password_confirmation]) if !params[:newpasswd].empty?
		respond_to do |format|
			format.json { render :json=>{:success=>flag }}
		end
	end

	def city
		respond_to do |format|
			format.js
			format.html
			format.json { render :json=>{:totalCount=>City.all.count, :gridData=> City.order('name').collect {|list| {:id=>list.id, :name=>list.name, :ip=>list.ip, :rootpasswd=>list.rootpasswd, :project_id=>list.project_id }}}}
		end
	end
	def station
		i=0
		respond_to do |format|
			format.js
			format.html
			format.json { render :json=>{:totalCount=>Station.all.count, :gridData=> Station.order('station_num').collect{ |list| i=i+1
            {:id=>list.id, :cityname=>(City.find_by_project_id(list.project_id).try(:name).nil? ? t('unknow city'): City.find_by_project_id(list.project_id).try(:name)), :station_name=>list.station_name, :station_num=>list.station_num, :online_state=>list.online_state, :online_time=>list.online_time, :offline_time=>list.offline_time, :offline_count=>list.offline_count, :update_percent=>list.update_percent, :update_speed=>list.update_speed, :sync_state=>list.sync_state, :service_state=>list.service_state}
          }
        }
      }
		end
	end
	def bus
		i=0
		respond_to do |format|
			format.js
			format.html
			format.json { render :json=>{:totalCount=>Bus.all.count, :gridData=> Bus.all.collect{ |list| i=i+1
            {:id=>list.id, :update_version=>(i%2==1 ? t('last first time') : t('last second time')),:cityname=>City.find_by_project_id(list.project_id).try(:name), :update_time=>list.updatetime, :update_cal=>list.updatecount.to_s+'/'+list.totalcount.to_s, :update_percent=>list.updatecount*1.0/list.totalcount}
          }
        }
      }
		end
	end
 def index
 end
 def test
  	@record=[]
  	respond_to do |format|
  		format.js
		format.html
  		format.json { render :json =>{ :totalCount=>10, :gridData=> @record.collect { |list| { :code=>list.code }} }}
  	end
  end
  
  def init
  	respond_to do |format|
		format.html
  		format.js
  	end
  end
end
