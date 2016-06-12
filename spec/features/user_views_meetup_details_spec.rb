require 'spec_helper'

feature "user views meetup details" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  let(:user2) do
    User.create(
      provider: "github",
      uid: "2",
      username: "herpderp",
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

  let(:member) do
    Member.create(
      user_id: user.id,
      meetup_id: meetup.id,
      creator: true
    )
  end

  let(:member2) do
    Member.create(
    user_id: user2.id,
    meetup_id: meetup.id
    )
  end

  let (:set_up) do
    user
    user2
    meetup
    member
    member2
  end

  scenario "user sees all of the meetup details" do
    set_up
    visit '/'
    click_link("test meetup")

    expect(page).to have_content "test meetup"
    expect(page).to have_content "Description: This is our meetup"
    expect(page).to have_content "Location: Boston"
    expect(page).to have_content "Creator: jarlax1"
    expect(page).to have_content "Members:"
    expect(page).to have_content "herpderp"
    expect(page).to have_xpath("//img[@src=\"https://avatars2.githubusercontent.com/u/174825?v=3&s=400\"]")

  end
end
