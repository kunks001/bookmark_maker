require 'sinatra'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'rack-flash'
require 'haml'
require 'sinatra/partial'
require 'pony'
require 'mime/types'
require 'rest_client'

class Server < Sinatra::Base

  plaintext = MIME::Types['text/plain']
  text      = plaintext.first
  puts text.media_type            # => 'text'
  puts text.sub_type              # => 'plain'

  puts text.extensions.join(" ")  # => 'txt asc c cc h hh cpp hpp dat hlp'

  puts text.encoding              # => quoted-printable
  puts text.binary?               # => false
  puts text.ascii?                # => true
  puts text.obsolete?             # => false
  puts text.registered?           # => true
  puts text == 'text/plain'       # => true
  puts MIME::Type.simplified('x-appl/x-zip')
                                  # => 'appl/zip'

  puts MIME::Types.any? { |type|
    type.content_type == 'text/plain'
  }                               # => true
  puts MIME::Types.all?(&:registered?)
                                  # => false

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