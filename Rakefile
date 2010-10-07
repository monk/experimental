task :test do
  $:.unshift(*Dir["./vendor/gems/*/lib", "./test"])
  require "cutest"

  Cutest.run(Dir["./test/**/*_test.rb"])
end

task :default => :test
