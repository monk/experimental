$:.unshift(*Dir["./vendor/*/lib"])

require "sinatra/base"
require "haml"
require "sass"
require "rtopia"
require "pagination"

class Main < Sinatra::Base
  set    :root,  lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set    :haml,  :escape_html => true, :format => :html5, :ugly => true
  set    :views, root("app", "views")

  enable :sessions, :logging, :show_exceptions, :raise_errors

  # Files to load
  set    :files, [ './config/*.defaults.rb',
                   './config/*.rb',
                   './lib/*.rb',
                   './app/**/*.rb' ]

  configure :development do
    require "pistol"
    use Pistol, Dir[*Main.files] { reset! and load(__FILE__) }
  end

  helpers Rtopia, Pagination::Helpers
end

Dir[*Main.files].each { |rb| require rb }

Main.run! if __FILE__ == $0
