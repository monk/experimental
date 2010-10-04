class Pistol
  attr :options

  def initialize(app, options = {})
    @options = options
    @options[:files] ||= Dir["./app/**/*.rb"]

    @app  = app
    @last = last_mtime
  end

  def call(env)
    current = last_mtime

    if current > @last
      if Thread.list.size > 1
        Thread.exclusive { reload! }
      else
        reload!
      end

      @last = current
    end

    @app.call(env)
  end

  def reload!
    options[:files].each do |file|
      $LOADED_FEATURES.delete(File.expand_path(file))
    end

    @app.class.reset! if @app.class.respond_to?(:reset!)
  
    require File.expand_path(options[:files].first)
  end

  # Returns the timestamp of the most recently modified file.
  def last_mtime
    options[:files].map do |file|
      ::File.stat(file).mtime
    end.max
  end
end

