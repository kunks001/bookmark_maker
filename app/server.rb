require 'sinatra'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'rack-flash'
require 'haml'
require 'sinatra/partial'

class Server < Sinatra::Base

  require_relative 'models/link'
  require_relative 'models/tag'
  require_relative 'models/user'
  require_relative 'helpers/application'
  require_relative 'data_mapper_setup'

  require_relative 'controllers/users'
  require_relative 'controllers/sessions'
  require_relative 'controllers/links'
  require_relative 'controllers/tags'
  require_relative 'controllers/application'

  helpers ApplicationHelper
  
  enable :sessions
  set :session_secret, 'super secret'

  register Sinatra::Partial

  use Rack::Flash
  use Rack::MethodOverride

end