class HardWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'sidekiq_job', :retry => false, :backtrace => true 
  def perform(type,string, count=5)
		# do somethings
     	puts 'Doing hard work'
		if !City.find(string).name.nil? && !City.find(string).ip.nil? 
			mkcmd="mkdir -p /opt/database/"+City.find(string).name
			system(mkcmd)
			cmd="mysqldump -u root -proot -h "+City.find(string).ip+" wiads_development>"+File.join('/opt/database',City.find(string).name+'/development.sql')
			status=system(cmd)
			City.find(string).update_attributes(:backup_status=>2, :backup_time=>Time.now.to_s.split('+')[0]) if  type=='backup' && status==true
			City.find(string).update_attributes(:backup_status=>3) if  type=='backup' && status==false
		end
		rescue=>exception
			raise exception
  end
end
