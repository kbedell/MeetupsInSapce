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

  scenario "user sees a list of all meetups" do
    meetup
    meetup2
    visit '/'

    expect(page).to have_content "test meetup"
    expect(page).to have_content "Description: This is our meetup"
    expect(page).to have_content "Location: Boston"

    expect("A meetup").to appear_before("test meetup")
  end
end
