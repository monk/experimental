class Monk < Thor
  include Thor::Actions

  desc "test", "Run all tests"
  def test
    verify_config

    $:.unshift File.join(File.dirname(__FILE__), "test")

    require 'cutest'
    Cutest.run(Dir['./test/**/*_test.rb'])
  end

  desc "start", "Start Monk"
  def start
    verify_config
    invoke :redis

    exec "ruby init.rb"
  end

  desc "copy_example EXAMPLE, TARGET", "Copies an example file to its destination"
  def copy_example(example, target = target_file_for(example))
    File.exists?(target) ? return : say_status(:missing, target)
    File.exists?(example) ? copy_file(example, target) : say_status(:missing, example)
  end

  REDIS_CNF = File.expand_path(File.join("config", "redis.conf"), File.dirname(__FILE__))
  REDIS_PID = File.expand_path(File.join("db", "redis.pid"), File.dirname(__FILE__))

  desc "redis START|STOP", "Start the Redis server"
  def redis(action = "start")
    verify "config/redis.example.conf"

    case action
    when "start" then redis_start
    when "stop"  then redis_stop
    else say_status(:error, "Usage: monk redis start|stop")
    end
  end

private

  def self.source_root
    File.dirname(__FILE__)
  end

  def target_file_for(example_file)
    example_file.sub(".example", "")
  end

  def verify_config
    verify "config/settings.example.rb"
    verify "config/redis.example.conf"
  end

  def verify(example)
    copy_example(example) unless File.exists?(target_file_for(example))
  end

  def redis_start
    unless File.exists?(REDIS_PID)
      system "redis-server #{REDIS_CNF}"
      if $?.success?
        say_status :success, "Redis started"
      else
        say_status :error, "Redis failed to start"
        say_status :solution, "Make sure Redis is installed correctly and redis-server is available. The configuration files are located in config/redis."
        exit(1)
      end
    end
  end

  def redis_stop
    if File.exists?(REDIS_PID)
      say_status :success, "Redis stopped"
      system "kill #{File.read(REDIS_PID)}"
      system "rm #{REDIS_PID}"
    end
  end
end

