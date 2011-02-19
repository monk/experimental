$:.unshift *Dir["./vendor/*/lib"]

begin
  gem 'sinatra', '~> 1.1'
  gem 'haml', '~> 3.0'
  require "sinatra/base"
  require "haml"
  require "sass"
  require "rtopia"
  require "pagination"
rescue LoadError => e
  $stderr.write "Not all gems were able to load. (#{e.message.strip})\n"
  $stderr.write "Do `monk install` first, or install the gems in .gems yourself.\n"
  exit
end

class Main < Sinatra::Base
  set    :root,  lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set    :haml,  :escape_html => true, :format => :html5, :ugly => true
  set    :views, root("app", "views")
  set    :run,   lambda { __FILE__ == $0 and not running? }

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

Main.run! if Main.run?
