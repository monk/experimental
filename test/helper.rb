ENV["RACK_ENV"] = "test"

require File.join(File.dirname(__FILE__), "..", "init")

require "cutest"
require "spawn"
require "capybara/dsl"

Ohm.connect(db: 1)

prepare do
  Ohm.flush
  Capybara.app = Main.new
end

module Kernel
  def fixture(file)
    File.open Main.root("test", "fixtures", "files", file)
  end
  private :fixture
end

class Story < Cutest::Scope
  include Capybara

  alias :scenario :test

  # For cases where you want to directly post. Note that this only works for
  # rack-test.
  def post(path, *args)
    page.driver.post(path, *args)
    page.driver.follow_redirects!
  end

  # define your story helpers here
end

def story(&blk)
  Story.new(&blk).call
end
