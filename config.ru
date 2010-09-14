require "./init"

Main.set :run, false

logger = ::File.open("log/main.log", "a+")
STDOUT.reopen(logger)
STDERR.reopen(logger)
STDOUT.sync = true
STDERR.sync = true

Main.use Rack::CommonLogger, logger

run Main

