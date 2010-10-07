class Main
  get '/' do
    @redis = { 
      :port => Ohm.redis.client.port, 
      :host => Ohm.redis.client.host
    }

    haml :home
  end
end

