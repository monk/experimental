class Main
  get "/css/:stylesheet.css" do |stylesheet|
    scss :"css/#{stylesheet}"
  end
end