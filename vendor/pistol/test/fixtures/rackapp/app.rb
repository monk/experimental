require File.expand_path("./app/article", File.dirname(__FILE__))
require File.expand_path("./lib/book",    File.dirname(__FILE__))
require File.expand_path("../../../lib/pistol", File.dirname(__FILE__))

$rackapp = Rack::Builder.app do
  use Pistol, Dir[__FILE__,
    File.expand_path("app/article.rb", File.dirname(__FILE__))] do
    load __FILE__
  end

  run(lambda { |env|
    case env["PATH_INFO"]
    when "/hello"
      [200, { "Content-Type" => "text/html" }, ["Hello"]]
    when "/article"
      [200, { "Content-Type" => "text/html" }, [Article.content]]
    when "/book"
      [200, { "Content-Type" => "text/html" }, [Book.title]]
    else
      [404, { "Content-Type" => "text/html" }, ["Not Found"]]
    end
  })
end