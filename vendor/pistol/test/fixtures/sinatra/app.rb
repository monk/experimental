require "sinatra/base"
require File.expand_path("./app/article", File.dirname(__FILE__))
require File.expand_path("./lib/book",    File.dirname(__FILE__))
require File.expand_path("../../../lib/pistol", File.dirname(__FILE__))

class App < Sinatra::Base
  set :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set :port, 9595

  use Pistol, Dir[__FILE__, root("app/**/*.rb")] do
    self.reset!
    require __FILE__
  end

  get "/hello" do
    "Hello"
  end

  get "/article" do
    Article.content
  end

  get "/book" do
    Book.title
  end
end

App.run! if __FILE__ == $0