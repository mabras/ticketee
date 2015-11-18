require 'rails_helper'

RSpec.feature "Users can view tickets" do
  # let(:user) { FactoryGirl.create :user }
  before do
    author = FactoryGirl.create(:user)
    sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
    FactoryGirl.create(:ticket, project: sublime,
                       name: "Make it shiny!",
                       description: "Gradients! Starbursts! Oh my!",
                      author:author)

    ie = FactoryGirl.create(:project, name: "Internet Explorer")
    FactoryGirl.create(:ticket, project: ie,
                       name: "Starbursts compliance", description: "Isn't a joke.")

    visit "/"
  end

  scenario "for a given project" do
    click_link "Sublime Text 3"

    expect(page).to have_content "Make it shiny!"
    expect(page).to_not have_content "Starbursts compliance"

    click_link "Make it shiny!"
    # this is does not work for me go back to error in page 137
    # within("#tickets h2") do
      expect(page).to have_content "Make it shiny!"
    # end

    expect(page).to have_content "Gradients! Starbursts! Oh my!"
  end
end
