require "cuba"
require File.expand_path("./app/article", File.dirname(__FILE__))
require File.expand_path("./lib/book",    File.dirname(__FILE__))
require File.expand_path("../../../lib/pistol", File.dirname(__FILE__))

Cuba.use Pistol, Dir[__FILE__,
  File.expand_path("./app/article.rb", File.dirname(__FILE__))] do
  Cuba.reset!
  load File.expand_path(__FILE__)
end

Cuba.define do
  on get do
    on path("hello") do
      res.write "Hello"
    end

    on path("article") do
      res.write Article.content
    end

    on path("book") do
      res.write Book.title
    end
  end
end

if __FILE__ == $0
  Rack::Handler::WEBrick.run(Cuba,
    :Port => 9797,
    :AccessLog => []
  )
end
