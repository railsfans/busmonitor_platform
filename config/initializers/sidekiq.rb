redis_server='127.0.0.1'
redis_port=6379
redis_db_num=0
redis_namespace="redis_sidekiq"

Sidekiq.configure_server do |config|
	p redis_server
	config.redis={url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace}
end

Sidekiq.configure_client do |config|
	config.redis={url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace}
end
