class Main
  get '/' do
    require 'maruku'
    readme = Main.root('README.markdown')
    text   = File.open(readme) { |f| f.read }
    text   = text.force_encoding("UTF-8")
    text   = text.match(/Welcome.*$/m)[0]  if text['Welcome']

    @home_text = Maruku.new(text).to_html

    haml :home
  end
end
