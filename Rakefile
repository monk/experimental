task :test do
  require 'cutest'
  $:.unshift('./test')
  
  Cutest.run(Dir['./test/**/*_test.rb'])
end

task :default => :test

