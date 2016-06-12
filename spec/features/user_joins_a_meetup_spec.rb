require 'spec_helper'

feature "user joins a meetup" do
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

  let (:set_up) do
    user
    user2
    meetup
    member
  end

  scenario "user clicks on Join Meetup" do
    set_up
    visit '/'
    sign_in_as user2
    click_link("test meetup")
    click_button("Join Meetup")

    expect(page).to have_content("herpderp")
    expect(page).to have_xpath("//img[@src=\"https://avatars2.githubusercontent.com/u/174825?v=3&s=400\"]")
    # expect(page).to have_content("You successfully joined the meetup")
  end
end
