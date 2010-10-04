$:.unshift(*Dir["./vendor/gems/*/lib"])

require "sinatra/base"
require "ohm"
require "ohm/contrib"
require "rtopia"
require "pagination"

require "./lib/pistol"

class Main < Sinatra::Base
  def self.root_path(*args)
    File.join(File.dirname(__FILE__), *args)
  end

  use Rack::Session::Cookie

  set :views, root_path("app", "views")
  set :root,  root_path

  enable :raise_errors

  helpers Rtopia, Pagination::Helpers

  use Pistol, :files => Dir[__FILE__, "./app/**/*.rb"]

  load "./config/settings.rb"
end

Dir["./lib/*.rb", "./app/**/*.rb"].each { |rb| require rb }

Main.run! if __FILE__ == $0

