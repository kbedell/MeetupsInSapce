require 'spec_helper'

feature "user views all meetups" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  let(:meetup) do
    Meetup.create(
      name: "test meetup",
      description: "This is our meetup",
      location: "Boston"
      )
  end

  let(:meetup2) do
    Meetup.create(
      name: "A meetup",
      description: "This is our meetup",
      location: "Boston"
      )
  end

  let(:set_up) do
    user
    meetup
    meetup2
  end

  scenario "user sees a list of all meetups" do
    set_up
    visit '/'

    expect(page).to have_content "test meetup"
    expect(page).to have_no_content "Description: This is our meetup"
    expect(page).to have_no_content "Location: Boston"
  end

  scenario "the list should be displayed in alphabetical order" do
    set_up
    visit '/'
    expect("A meetup").to appear_before("test meetup")
  end
end
