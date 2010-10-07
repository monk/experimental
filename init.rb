$:.unshift(*Dir["./vendor/*/lib"])

require "sinatra/base"
require "ohm"
require "ohm/contrib"
require "rtopia"
require "pagination"
require "./lib/pistol"

class Main < Sinatra::Base
  set    :root,      File.dirname(__FILE__)
  set    :root_path, lambda { |*args| File.join(root, *args) }
  set    :haml,      :escape_html => true, :format => :html5, :ugly => true
  set    :views,     root_path("app", "views")

  enable :raise_errors

  use Rack::Session::Cookie
  use Pistol, :files => Dir[__FILE__, "./app/**/*.rb"]

  helpers Rtopia, Pagination::Helpers

  load "./config/settings.rb"
end

Dir["./lib/*.rb", "./app/**/*.rb"].each { |rb| require rb }

Main.run! if __FILE__ == $0
