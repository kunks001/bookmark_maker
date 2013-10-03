env = ENV["RACK_ENV"] || "development"
@db_url = ENV["DATABASE_URL"] if env == "production"

DataMapper.setup(:default, @db_url || "postgres://localhost/bookmark_manager_#{env}")
require_relative 'models/favourite'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'
DataMapper.finalize
DataMapper.auto_upgrade!