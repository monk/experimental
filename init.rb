$:.unshift(*Dir['./vendor/gems/*/lib'])

require 'sinatra/base'
require 'ohm'
require 'ohm/contrib'
require 'rtopia'
require 'pagination'

class Main < Sinatra::Base
  def self.root_path(*args)
    File.join(File.dirname(__FILE__), *args)
  end

  use Rack::Session::Cookie

  set :views, root_path('app', 'views')
  set :root,  root_path

  enable :raise_errors

  helpers Rtopia, Pagination::Helpers
end

begin
  require './config/settings'
rescue LoadError
  puts "!! Settings not found. Try doing `cp config/settings{.example,}.rb`."
end

Dir['./lib/*.rb', './app/**/*.rb'].each { |rb| require rb }

Main.run! if __FILE__ == $0

