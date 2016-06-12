require 'spec_helper'

feature "user leaves a meetup space" do
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

  let(:set_up) do
    user
    user2
    meetup
    member
    member2
  end

  scenario "Member sees a leave meetup button" do
    set_up
    visit '/'
    sign_in_as user2
    click_link("test meetup")

    find_button('Leave Meetup').click
  end

  scenario "Member leaves a meetup" do
    set_up
    visit '/'
    sign_in_as user2
    click_link("test meetup")

    click_button('Leave Meetup')
    expect(page).to have_content("You have successfully left the meetup")
  end
end
