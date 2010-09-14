ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'init')

require 'cutest'
require 'spawn'
require 'capybara/dsl'

Ohm.connect(db: 1)

module Kernel
  def fixture(file)
    File.open Main.root_path('test', 'fixtures', 'files', file)
  end
  private :fixture
end

module Story
  extend Capybara

  class << self
    alias :scenario :test
  end
end

def Story(str, &blk)
  Story.instance_eval(&blk) 
end

