require File.expand_path("./helper", File.dirname(__FILE__))

scope do
  app    "sinatra"
  server "http://localhost:9595"

  test "/hello" do
    assert "Hello" == get("/hello")
  end

  test "/hello when modified" do
    modify("app.rb", %{"Hello"}, %{"New Hello"}) do
      assert "New Hello" == get("/hello")
    end
  end

  test "/article changes when Article is changed" do
    assert "Hello World v1" == get("/article")

    modify("app/article.rb", %{"Hello World v1"}, %{"Hello World v2"}) do
      assert "Hello World v2" == get("/article")
    end
  end

  test "/book doesn't change since Book is in lib" do
    assert "Sinatra Book" == get("/book")

    modify("lib/book.rb", %{"Sinatra Book"}, %{"Rack Book"}) do
     assert "Sinatra Book" == get("/book")
    end
  end
end