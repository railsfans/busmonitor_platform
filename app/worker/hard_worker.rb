class HardWorker
	include Sidekiq::Worker
  	sidekiq_options :queue => 'sidekiq_job', :retry => false, :backtrace => true 
  	def perform(type,string, count=5)
		# do somethings
		case type
			when 'backup'
     			puts 'backup cmd'
				if !City.find(string).name.nil? 
					mkcmd="mkdir -p /opt/database/"+City.find(string).name
					system(mkcmd)
					cmd="mysqldump -u root -proot -h "+City.find(string).ip+" wiads_development>"+File.join('/opt/database',City.find(string).name+'/development.new.sql')
					status=system(cmd)
					if status
						City.find(string).update_attributes(:backup_status=>2, :backup_time=>Time.now.to_s.split('+')[0]) 
						mvcmd="cd "+File.join('/opt/database',City.find(string).name)+"; rm -rf development.old.sql; mv development.sql development.old.sql; mv development.new.sql development.sql"
						system(mvcmd)
					else
						City.find(string).update_attributes(:backup_status=>3) 
						rmcmd="cd "+File.join('/opt/database',City.find(string).name)+"; rm -rf development.new.sql"
						system(rmcmd)
					end
				end
			when 'deploy'
				puts 'deploy cmd here'
				createcmd="cd /opt/tmp/cap; cp Capfile_common Capfile"
				system(createcmd)
				passwd=City.find(string).rootpasswd
				ip=City.find(string).ip
				project_id=City.find(string).project_id
				puts 'deploy cmds'
				initcmd="echo \"set 'project_id', '"+project_id+"'\">>/opt/tmp/cap/Capfile;"+"echo \"set :password, '"+passwd+"'\">>/opt/tmp/cap/Capfile;echo \"role :remoteServer, '"+ip+"'\">>/opt/tmp/cap/Capfile"
				status=system(initcmd)
				puts status
				puts initcmd
				deploycmd="cd /opt/tmp/cap; cap se:install"
				status=system(deploycmd)
				if status
					City.find(string).update_attributes(:deploy_status=>2, :deploy_time=>Time.now.to_s.split('+')[0])
				else
					City.find(string).update_attributes(:deploy_status=>3)
				end
			else
				puts 'error cmd'
		end
		rescue=>exception
			raise exception
  	end
end
