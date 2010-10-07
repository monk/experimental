require File.expand_path("../helper", File.dirname(__FILE__))

Story "As a user I can view the site homepage" do
  setup do
    Capybara.app = Main.new
  end

  scenario "No query string" do
    visit "/"

    assert page.has_content?("Monk 2 Experimental")
  end
end
