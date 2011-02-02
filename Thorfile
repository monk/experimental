class Monk < Thor
  include Thor::Actions

  desc "test", "Run all tests"
  def test
    verify_config
    $:.unshift File.join(File.dirname(__FILE__), "test")

    require 'cutest'
    Cutest.run(Dir['./test/**/*_test.rb'])
  end

  desc "start", "Start the server"
  def start
    exec "ruby init.rb"
  end

  desc "irb", "Open a console"
  def irb
    exec "irb -r./init.rb"
  end

private
  def self.source_root
    File.dirname(__FILE__)
  end

  def exec(cmd)
    say_status :run, cmd
    super
  end
end
