class Main
  helpers do
    def haml(template, options = {}, locals = {})
      options[:escape_html] = true unless options.include?(:escape_html)
      options[:format] = :html5
      options[:ugly] = true

      super(template, options, locals)
    end

    def partial(template, locals = {})
      haml(template, { :layout => false }, locals)
    end

    # If you prefer url(:post, @post) instead of R(:post, @post)
    # def url(*args)
    #   R(*args)
    # end
  end
end

