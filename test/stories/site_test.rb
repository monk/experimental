require "helper"

Story("As a user I can view the site homepage") do
  setup do
    Capybara.app = Main.new
  end

  scenario "No query string" do
    visit '/'

    assert page.has_content?('Welcome to the Monk 2 Skeleton!')
  end
end

