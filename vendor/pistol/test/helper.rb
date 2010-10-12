require "cutest"
require "open-uri"
require "fileutils"

class Cutest::Scope
  def app(app = nil)
    @app = app if app
    @app
  end

  def server(server = nil)
    @server = server if server
    @server
  end

  def get(path)
    open([server, path].join).read
  end

  def app_root(*args)
    File.join(File.dirname(__FILE__), "fixtures", app, *args)
  end

  def modify(file, old, new)
    path = app_root(file)

    prev = File.read(path)
    change(path, prev.gsub(old, new))
    sleep 1
    FileUtils.touch(path)
    yield
  ensure
    change(path, prev)
  end

  def updated(file)
    sleep 1
    FileUtils.touch(app_root(file))
    yield
  end

  def change(file, data)
    File.open(file, "w") { |f| f.write data }
  end
end