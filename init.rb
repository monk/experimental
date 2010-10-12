$:.unshift(*Dir["./vendor/*/lib"])

require "sinatra/base"
require "haml"
require "sass"
require "ohm"
require "ohm/contrib"
require "rtopia"
require "pagination"

class Main < Sinatra::Base
  set    :root,  lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set    :haml,  :escape_html => true, :format => :html5, :ugly => true
  set    :views, root("app", "views")

  enable :raise_errors

  use Rack::Session::Cookie

  configure :development do
    require "pistol"

    use Pistol, Dir["./app/**/*.rb", "./lib/*.rb"] do
      reset! and load(__FILE__)
    end
  end

  helpers Rtopia, Pagination::Helpers

  load "./config/settings.rb"
end

Dir["./lib/*.rb", "./app/**/*.rb"].each { |rb| require rb }

Main.run! if __FILE__ == $0
