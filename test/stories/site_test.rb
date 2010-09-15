require "helper"

Story("As a user I can view the site homepage") do
  setup do
    Capybara.app = Main.new
  end

  scenario "No query string" do
    visit '/'

    assert page.has_content?('Hello, world!')
  end
end

