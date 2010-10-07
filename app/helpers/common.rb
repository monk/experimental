class Main
  helpers do
    def partial(template, locals = {})
      haml(template, { :layout => false }, locals)
    end

    # If you prefer url(:post, @post) instead of R(:post, @post)
    # def url(*args)
    #   R(*args)
    # end
  end
end

