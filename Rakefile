task :test do
  system "monk test"
end
task :default => :test

task :seed do
  require "./init"
  require "batch"

  # Basic seed example.
  # puts "#### Creating 30 entries of Foo."
  # Batch.each((1..30).to_a) do
  #   # do something here
  # end
end